import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mcp_visualizer/features/event_log/domain/models/log_entry.dart';
import 'package:mcp_visualizer/features/event_log/presentation/providers/event_log_provider.dart';
import 'package:mcp_visualizer/features/event_log/presentation/widgets/log_entry_tile.dart';
import 'package:mcp_visualizer/features/event_log/presentation/widgets/log_filter_bar.dart';
import 'package:mcp_visualizer/shared/widgets/empty_state.dart';

class EventLogScreen extends ConsumerStatefulWidget {
  const EventLogScreen({super.key});

  @override
  ConsumerState<EventLogScreen> createState() => _EventLogScreenState();
}

class _EventLogScreenState extends ConsumerState<EventLogScreen> {
  final _scrollController = ScrollController();
  Set<LogLevel> _levels = Set.of(LogLevel.values);
  Set<LogCategory> _categories = Set.of(LogCategory.values);

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allEntries = ref.watch(eventLogProvider);
    final filtered = allEntries
        .where(
          (e) => _levels.contains(e.level) && _categories.contains(e.category),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Log'),
        actions: [
          // Export action
          IconButton(
            icon: const Icon(Icons.share_outlined),
            tooltip: 'Export log',
            onPressed: allEntries.isEmpty ? null : () => _export(allEntries),
          ),
          // Clear action
          IconButton(
            icon: const Icon(Icons.delete_sweep_outlined),
            tooltip: 'Clear log',
            onPressed: allEntries.isEmpty
                ? null
                : () => ref.read(eventLogProvider.notifier).clear(),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: LogFilterBar(
            selectedLevels: _levels,
            selectedCategories: _categories,
            onLevelToggled: (l) => setState(() {
              if (_levels.contains(l)) {
                if (_levels.length > 1) _levels = {..._levels}..remove(l);
              } else {
                _levels = {..._levels, l};
              }
            }),
            onCategoryToggled: (c) => setState(() {
              if (_categories.contains(c)) {
                if (_categories.length > 1) {
                  _categories = {..._categories}..remove(c);
                }
              } else {
                _categories = {..._categories, c};
              }
            }),
          ),
        ),
      ),
      body: filtered.isEmpty
          ? EmptyState(
              icon: Icons.receipt_long_outlined,
              message: allEntries.isEmpty
                  ? 'No events yet. Connect to a server to start logging.'
                  : 'No entries match the current filters.',
            )
          : ListView.separated(
              controller: _scrollController,
              reverse: true, // newest first
              itemCount: filtered.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, i) => LogEntryTile(entry: filtered[i]),
            ),
    );
  }

  Future<void> _export(List<LogEntry> entries) async {
    final buffer = StringBuffer();
    for (final e in entries.reversed) {
      final local = e.timestamp.toLocal();
      buffer.writeln(
        '[${local.toIso8601String()}] [${e.level.name.toUpperCase()}] [${e.category.name}] ${e.message}',
      );
    }
    final text = buffer.toString();
    await Clipboard.setData(ClipboardData(text: text));
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Log copied to clipboard')));
    }
  }
}
