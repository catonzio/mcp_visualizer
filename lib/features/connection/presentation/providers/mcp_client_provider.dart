import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mcp_client/mcp_client.dart'
    hide ServerInfo, Disconnected, Connecting, Connected, ConnectionError;

import 'package:mcp_visualizer/core/errors/mcp_failure.dart';
import 'package:mcp_visualizer/features/connection/data/repositories/mcp_connection_repository_impl.dart';
import 'package:mcp_visualizer/features/connection/domain/models/connection_state.dart';
import 'package:mcp_visualizer/features/connection/domain/models/server_info.dart';
import 'package:mcp_visualizer/features/connection/domain/repositories/mcp_connection_repository.dart';
import 'package:mcp_visualizer/features/servers/data/repositories/server_profile_repository_impl.dart';
import 'package:mcp_visualizer/features/servers/domain/models/server_profile.dart';
import 'package:mcp_visualizer/features/servers/presentation/providers/server_profile_providers.dart';

// ---------------------------------------------------------------------------
// Repository provider
// ---------------------------------------------------------------------------

final mcpConnectionRepositoryProvider = Provider<McpConnectionRepository>((
  ref,
) {
  return McpConnectionRepositoryImpl();
});

// ---------------------------------------------------------------------------
// Client notifier — one instance per server profile id (family keyed by id)
// ---------------------------------------------------------------------------

class McpClientNotifier extends Notifier<McpConnectionState> {
  McpClientNotifier(this.serverId);

  final String serverId;
  Client? _client;

  Client? get client => _client;

  @override
  McpConnectionState build() => const McpConnectionState.disconnected();

  Future<void> connect(ServerProfile profile) async {
    state = const McpConnectionState.connecting();

    // Optionally load auth token from secure storage
    String? authToken;
    try {
      final repo = ref.read(serverProfileRepositoryProvider);
      if (repo is ServerProfileRepositoryImpl) {
        authToken = await repo.readAuthToken(profile.id);
      }
    } catch (_) {
      // Non-fatal — continue without token
    }

    final connRepo = ref.read(mcpConnectionRepositoryProvider);
    final result = await connRepo.connect(profile, authToken: authToken).run();

    await result.fold(
      (failure) async {
        state = McpConnectionState.error(failure: failure);
      },
      (client) async {
        _client = client;

        // By the time createAndConnect resolves, the connection is already
        // established and onConnect has already fired. Read server info directly.
        final rawInfo = client.serverInfo;
        state = McpConnectionState.connected(
          serverInfo: ServerInfo(
            name: rawInfo?['name'] as String? ?? 'Unknown',
            version: rawInfo?['version'] as String? ?? 'unknown',
            protocolVersion: client.protocolVersion,
          ),
        );

        // Stamp last-connected on the profile
        final updatedProfile = profile.copyWith(
          lastConnectedAt: DateTime.now(),
        );
        ref.read(serverProfileNotifierProvider.notifier).save(updatedProfile);

        // Subscribe to lifecycle events
        client.onDisconnect.listen((_) {
          _client = null;
          state = const McpConnectionState.disconnected();
        });

        client.onError.listen((error) {
          state = McpConnectionState.error(
            failure: McpFailure.unknown(message: error.message),
          );
        });
      },
    );
  }

  Future<void> disconnect() async {
    final c = _client;
    if (c == null) return;
    final connRepo = ref.read(mcpConnectionRepositoryProvider);
    await connRepo.disconnect(c).run();
    _client = null;
    state = const McpConnectionState.disconnected();
  }
}

final mcpClientNotifierProvider =
    NotifierProvider.family<McpClientNotifier, McpConnectionState, String>(
      (serverId) => McpClientNotifier(serverId),
    );

// ---------------------------------------------------------------------------
// Convenience providers (family keyed by server profile id)
// ---------------------------------------------------------------------------

/// The current [McpConnectionState] for a given server profile id.
final connectionStateProvider = Provider.family<McpConnectionState, String>((
  ref,
  serverId,
) {
  return ref.watch(mcpClientNotifierProvider(serverId));
});

/// The raw [Client] instance for a given server profile id, or null if disconnected.
final mcpClientProvider = Provider.family<Client?, String>((ref, serverId) {
  final notifier = ref.watch(mcpClientNotifierProvider(serverId).notifier);
  ref.watch(mcpClientNotifierProvider(serverId)); // rebuild when state changes
  return notifier.client;
});
