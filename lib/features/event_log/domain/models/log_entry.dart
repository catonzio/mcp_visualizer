import 'package:freezed_annotation/freezed_annotation.dart';

part 'log_entry.freezed.dart';
part 'log_entry.g.dart';

enum LogLevel { debug, info, warning, error }

enum LogCategory { connection, tool, resource, prompt, system }

@freezed
abstract class LogEntry with _$LogEntry {
  const factory LogEntry({
    required String id,
    required DateTime timestamp,
    required LogLevel level,
    required LogCategory category,
    required String message,
    @Default({}) Map<String, dynamic> metadata,
  }) = _LogEntry;

  factory LogEntry.fromJson(Map<String, dynamic> json) =>
      _$LogEntryFromJson(json);
}
