import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mcp_client/mcp_client.dart'
    hide ServerInfo, Disconnected, Connecting, Connected, ConnectionError;
import 'package:mcp_client/mcp_client.dart' as mcp show ServerInfo;

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
// Client notifier — holds the live Client instance and connection state
// ---------------------------------------------------------------------------

class McpClientNotifier extends Notifier<McpConnectionState> {
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

        // Listen for server identity on connect
        client.onConnect.listen((mcp.ServerInfo mcpInfo) {
          state = McpConnectionState.connected(
            serverInfo: ServerInfo(
              name: mcpInfo.name,
              version: mcpInfo.version,
              protocolVersion: mcpInfo.protocolVersion ?? 'unknown',
            ),
          );
          // Stamp last-connected on the profile
          final updatedProfile = profile.copyWith(
            lastConnectedAt: DateTime.now(),
          );
          ref.read(serverProfileNotifierProvider.notifier).save(updatedProfile);
        });

        client.onDisconnect.listen((_) {
          _client = null;
          state = const McpConnectionState.disconnected();
        });

        client.onError.listen((error) {
          state = McpConnectionState.error(
            failure: McpFailure.unknown(message: error.message),
          );
        });

        // Register logging callback
        client.onLogging((level, data, logger, extra) {
          // Logging is consumed by event_log_provider via mcpClientProvider
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
    NotifierProvider<McpClientNotifier, McpConnectionState>(
      McpClientNotifier.new,
    );

// ---------------------------------------------------------------------------
// Convenience providers
// ---------------------------------------------------------------------------

/// The raw [Client] instance, or null if disconnected.
final mcpClientProvider = Provider<Client?>((ref) {
  final notifier = ref.watch(mcpClientNotifierProvider.notifier);
  ref.watch(mcpClientNotifierProvider); // rebuild when state changes
  return notifier.client;
});

final connectionStateProvider = Provider<McpConnectionState>((ref) {
  return ref.watch(mcpClientNotifierProvider);
});
