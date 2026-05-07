import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mcp_visualizer/core/errors/mcp_failure.dart';
import 'package:mcp_visualizer/features/connection/domain/models/connection_state.dart';
import 'package:mcp_visualizer/features/connection/presentation/providers/mcp_client_provider.dart';
import 'package:mcp_visualizer/features/connection/presentation/widgets/connection_status_badge.dart';
import 'package:mcp_visualizer/features/connection/presentation/widgets/server_info_card.dart';
import 'package:mcp_visualizer/features/servers/presentation/providers/server_profile_providers.dart';

class ConnectionScreen extends ConsumerStatefulWidget {
  const ConnectionScreen({super.key, required this.profileId});

  final String profileId;

  @override
  ConsumerState<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends ConsumerState<ConnectionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _connect());
  }

  Future<void> _connect() async {
    final profiles = ref.read(serverProfileNotifierProvider).asData?.value;
    if (profiles == null) return;
    final profile = profiles.firstWhere(
      (p) => p.id == widget.profileId,
      orElse: () => throw StateError('Profile not found'),
    );
    await ref.read(mcpClientNotifierProvider.notifier).connect(profile);
  }

  @override
  Widget build(BuildContext context) {
    final connectionState = ref.watch(connectionStateProvider);
    final profilesAsync = ref.watch(serverProfileNotifierProvider);

    final profileName = profilesAsync.asData?.value
            .where((p) => p.id == widget.profileId)
            .firstOrNull
            ?.name ??
        'Server';

    return Scaffold(
      appBar: AppBar(
        title: Text(profileName),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ConnectionStatusBadge(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: switch (connectionState) {
          Disconnected() => _DisconnectedView(onConnect: _connect),
          Connecting() => const _ConnectingView(),
          Connected() => _ConnectedView(
              onDisconnect: () async {
                await ref.read(mcpClientNotifierProvider.notifier).disconnect();
                if (context.mounted) context.pop();
              },
            ),
          ConnectionError(:final failure) => _ErrorView(
              message: failure.userMessage,
              onRetry: _connect,
            ),
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sub-views
// ---------------------------------------------------------------------------

class _DisconnectedView extends StatelessWidget {
  const _DisconnectedView({required this.onConnect});

  final VoidCallback onConnect;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.link_off, size: 48),
          const SizedBox(height: 16),
          const Text('Not connected'),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: onConnect,
            icon: const Icon(Icons.link),
            label: const Text('Connect'),
          ),
        ],
      ),
    );
  }
}

class _ConnectingView extends StatelessWidget {
  const _ConnectingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Connecting…'),
        ],
      ),
    );
  }
}

class _ConnectedView extends StatelessWidget {
  const _ConnectedView({required this.onDisconnect});

  final VoidCallback onDisconnect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ServerInfoCard(),
        const SizedBox(height: 16),
        const Text(
          'Use the Servers, Tools, Resources, and Prompts tabs to interact '
          'with this server.',
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        OutlinedButton.icon(
          onPressed: onDisconnect,
          icon: const Icon(Icons.link_off),
          label: const Text('Disconnect'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
            side: BorderSide(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 48, color: theme.colorScheme.error),
          const SizedBox(height: 16),
          Text(
            'Connection failed',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
