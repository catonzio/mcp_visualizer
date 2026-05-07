import 'package:flutter/material.dart';

import 'package:mcp_visualizer/features/event_log/domain/models/log_entry.dart';
import 'package:mcp_visualizer/shared/widgets/copy_button.dart';

class LogEntryTile extends StatefulWidget {
  const LogEntryTile({super.key, required this.entry});

  final LogEntry entry;

  @override
  State<LogEntryTile> createState() => _LogEntryTileState();
}

class _LogEntryTileState extends State<LogEntryTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entry = widget.entry;
    final levelColor = _levelColor(context, entry.level);
    final isLong = entry.message.length > 120;

    return InkWell(
      onTap: isLong ? () => setState(() => _expanded = !_expanded) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Level icon
            Padding(
              padding: const EdgeInsets.only(top: 2, right: 8),
              child: Icon(_levelIcon(entry.level), size: 16, color: levelColor),
            ),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row: timestamp + chips
                  Row(
                    children: [
                      Text(
                        _formatTime(entry.timestamp),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(width: 6),
                      _LevelChip(level: entry.level, color: levelColor),
                      const SizedBox(width: 4),
                      _CategoryChip(category: entry.category),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Message
                  SelectableText(
                    _expanded || !isLong
                        ? entry.message
                        : '${entry.message.substring(0, 120)}…',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  if (isLong)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        _expanded ? 'Show less' : 'Show more',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Copy button
            CopyButton(text: entry.message),
          ],
        ),
      ),
    );
  }

  Color _levelColor(BuildContext context, LogLevel level) {
    final cs = Theme.of(context).colorScheme;
    return switch (level) {
      LogLevel.debug => cs.onSurfaceVariant,
      LogLevel.info => cs.primary,
      LogLevel.warning => Colors.orange,
      LogLevel.error => cs.error,
    };
  }

  IconData _levelIcon(LogLevel level) => switch (level) {
    LogLevel.debug => Icons.bug_report_outlined,
    LogLevel.info => Icons.info_outline,
    LogLevel.warning => Icons.warning_amber_outlined,
    LogLevel.error => Icons.error_outline,
  };

  String _formatTime(DateTime dt) {
    final local = dt.toLocal();
    final h = local.hour.toString().padLeft(2, '0');
    final m = local.minute.toString().padLeft(2, '0');
    final s = local.second.toString().padLeft(2, '0');
    final ms = local.millisecond.toString().padLeft(3, '0');
    return '$h:$m:$s.$ms';
  }
}

class _LevelChip extends StatelessWidget {
  const _LevelChip({required this.level, required this.color});

  final LogLevel level;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final label = switch (level) {
      LogLevel.debug => 'DEBUG',
      LogLevel.info => 'INFO',
      LogLevel.warning => 'WARN',
      LogLevel.error => 'ERROR',
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.category});

  final LogCategory category;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final label = switch (category) {
      LogCategory.connection => 'conn',
      LogCategory.tool => 'tool',
      LogCategory.resource => 'res',
      LogCategory.prompt => 'prompt',
      LogCategory.system => 'sys',
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
