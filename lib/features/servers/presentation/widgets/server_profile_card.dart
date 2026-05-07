import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mcp_visualizer/core/errors/mcp_failure.dart';
import 'package:mcp_visualizer/core/utils/platform_utils.dart';
import 'package:mcp_visualizer/features/connection/domain/models/connection_state.dart';
import 'package:mcp_visualizer/features/connection/presentation/providers/mcp_client_provider.dart';
import 'package:mcp_visualizer/features/servers/domain/models/server_profile.dart';

class ServerProfileCard extends ConsumerWidget {
  const ServerProfileCard({
    super.key,
    required this.profile,
    required this.onEdit,
    required this.onDelete,
  });

  final ServerProfile profile;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final connectionState = ref.watch(connectionStateProvider(profile.id));

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          profile.name,
                          style: theme.textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _TransportBadge(transport: profile.transportType),
                    ],
                  ),
                  if (profile.lastConnectedAt != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Last connected: ${_formatDate(profile.lastConnectedAt!)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                  if (connectionState is ConnectionError) ...[
                    const SizedBox(height: 4),
                    Text(
                      connectionState.failure.userMessage,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              tooltip: 'Edit',
              icon: const Icon(Icons.edit_outlined),
              onPressed: onEdit,
            ),
            IconButton(
              tooltip: 'Delete',
              icon: Icon(Icons.delete_outline, color: theme.colorScheme.error),
              onPressed: onDelete,
            ),
            const SizedBox(width: 4),
            _ActionButton(profile: profile, connectionState: connectionState),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }
}

class _ActionButton extends ConsumerWidget {
  const _ActionButton({required this.profile, required this.connectionState});

  final ServerProfile profile;
  final McpConnectionState connectionState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (connectionState) {
      Connecting() => const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      Connected() => FilledButton(
        onPressed: () => context.push('/servers/${profile.id}'),
        child: const Text('Open'),
      ),
      Disconnected() || ConnectionError() => FilledButton.tonal(
        onPressed: () => _connect(ref, context),
        child: const Text('Connect'),
      ),
    };
  }

  Future<void> _connect(WidgetRef ref, BuildContext context) async {
    await ref
        .read(mcpClientNotifierProvider(profile.id).notifier)
        .connect(profile);
    final state = ref.read(connectionStateProvider(profile.id));
    if (state is Connected && context.mounted) {
      context.push('/servers/${profile.id}');
    }
  }
}

class _TransportBadge extends StatelessWidget {
  const _TransportBadge({required this.transport});

  final TransportType transport;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (transport) {
      TransportType.stdio => ('STDIO', Colors.purple),
      TransportType.sse => ('SSE', Colors.blue),
      TransportType.streamableHttp => ('HTTP', Colors.teal),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        border: Border.all(color: color.withAlpha(80)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}
