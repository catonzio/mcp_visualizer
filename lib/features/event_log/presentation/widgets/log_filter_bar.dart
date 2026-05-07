import 'package:flutter/material.dart';

import 'package:mcp_visualizer/features/event_log/domain/models/log_entry.dart';

/// Multi-select chip bar for filtering the event log by level and category.
class LogFilterBar extends StatelessWidget {
  const LogFilterBar({
    super.key,
    required this.selectedLevels,
    required this.selectedCategories,
    required this.onLevelToggled,
    required this.onCategoryToggled,
  });

  final Set<LogLevel> selectedLevels;
  final Set<LogCategory> selectedCategories;
  final void Function(LogLevel) onLevelToggled;
  final void Function(LogCategory) onCategoryToggled;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          ...LogLevel.values.map(
            (level) => Padding(
              padding: const EdgeInsets.only(right: 6),
              child: FilterChip(
                label: Text(_levelLabel(level)),
                selected: selectedLevels.contains(level),
                onSelected: (_) => onLevelToggled(level),
                avatar: Icon(
                  _levelIcon(level),
                  size: 14,
                  color: _levelColor(context, level),
                ),
                selectedColor: _levelColor(context, level).withAlpha(40),
                checkmarkColor: _levelColor(context, level),
                visualDensity: VisualDensity.compact,
              ),
            ),
          ),
          Container(
            width: 1,
            height: 20,
            color: Theme.of(context).colorScheme.outlineVariant,
            margin: const EdgeInsets.symmetric(horizontal: 8),
          ),
          ...LogCategory.values.map(
            (cat) => Padding(
              padding: const EdgeInsets.only(right: 6),
              child: FilterChip(
                label: Text(_catLabel(cat)),
                selected: selectedCategories.contains(cat),
                onSelected: (_) => onCategoryToggled(cat),
                visualDensity: VisualDensity.compact,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _levelLabel(LogLevel l) => switch (l) {
    LogLevel.debug => 'Debug',
    LogLevel.info => 'Info',
    LogLevel.warning => 'Warn',
    LogLevel.error => 'Error',
  };

  IconData _levelIcon(LogLevel l) => switch (l) {
    LogLevel.debug => Icons.bug_report_outlined,
    LogLevel.info => Icons.info_outline,
    LogLevel.warning => Icons.warning_amber_outlined,
    LogLevel.error => Icons.error_outline,
  };

  Color _levelColor(BuildContext context, LogLevel l) {
    final cs = Theme.of(context).colorScheme;
    return switch (l) {
      LogLevel.debug => cs.onSurfaceVariant,
      LogLevel.info => cs.primary,
      LogLevel.warning => Colors.orange,
      LogLevel.error => cs.error,
    };
  }

  String _catLabel(LogCategory c) => switch (c) {
    LogCategory.connection => 'Connection',
    LogCategory.tool => 'Tools',
    LogCategory.resource => 'Resources',
    LogCategory.prompt => 'Prompts',
    LogCategory.system => 'System',
  };
}
