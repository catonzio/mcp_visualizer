import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mcp_client/mcp_client.dart'
    hide ServerInfo, Disconnected, Connecting, Connected, ConnectionError;
import 'package:uuid/uuid.dart';

import 'package:mcp_visualizer/core/errors/mcp_failure.dart';
import 'package:mcp_visualizer/features/connection/domain/models/connection_state.dart';
import 'package:mcp_visualizer/features/connection/presentation/providers/mcp_client_provider.dart';
import 'package:mcp_visualizer/features/event_log/domain/models/log_entry.dart';

const _uuid = Uuid();
const int _maxEntries = 1000;

class EventLogNotifier extends Notifier<List<LogEntry>> {
  EventLogNotifier(this.serverId);

  final String serverId;

  @override
  List<LogEntry> build() {
    // Subscribe to connection state changes
    ref.listen(connectionStateProvider(serverId), (prev, next) {
      final (msg, level) = switch (next) {
        Disconnected() => ('Disconnected from server', LogLevel.info),
        Connecting() => ('Connecting to server…', LogLevel.info),
        Connected(serverInfo: final info) => (
          'Connected — ${info.name} ${info.version} (${info.protocolVersion})',
          LogLevel.info,
        ),
        ConnectionError(failure: final f) => (
          'Connection error: ${f.userMessage}',
          LogLevel.error,
        ),
      };
      _append(level: level, category: LogCategory.connection, message: msg);
    });

    // Subscribe to raw MCP client logging events
    ref.listen(mcpClientProvider(serverId), (prev, next) {
      if (next == null || next == prev) return;
      next.onLogging((
        McpLogLevel level,
        String data,
        String? logger,
        Map<String, dynamic>? extra,
      ) {
        _append(
          level: _mapLevel(level.name),
          category: LogCategory.system,
          message: data,
          metadata: extra ?? {},
        );
      });
    });

    return [];
  }

  void _append({
    required LogLevel level,
    required LogCategory category,
    required String message,
    Map<String, dynamic> metadata = const {},
  }) {
    final entry = LogEntry(
      id: _uuid.v4(),
      timestamp: DateTime.now(),
      level: level,
      category: category,
      message: message,
      metadata: metadata,
    );
    final updated = [entry, ...state];
    state = updated.length > _maxEntries
        ? updated.sublist(0, _maxEntries)
        : updated;
  }

  void clear() => state = [];

  LogLevel _mapLevel(String level) => switch (level.toLowerCase()) {
    'debug' => LogLevel.debug,
    'warning' || 'warn' => LogLevel.warning,
    'error' => LogLevel.error,
    _ => LogLevel.info,
  };
}

final eventLogProvider =
    NotifierProvider.family<EventLogNotifier, List<LogEntry>, String>(
      (serverId) => EventLogNotifier(serverId),
    );
