import 'package:flutter/material.dart';

import 'package:mcp_visualizer/core/utils/platform_utils.dart';
import 'package:mcp_visualizer/features/servers/domain/models/server_profile.dart';

class ServerProfileCard extends StatelessWidget {
  const ServerProfileCard({
    super.key,
    required this.profile,
    required this.onConnect,
    required this.onEdit,
    required this.onDelete,
  });

  final ServerProfile profile;
  final VoidCallback onConnect;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            FilledButton.tonal(
              onPressed: onConnect,
              child: const Text('Connect'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
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
