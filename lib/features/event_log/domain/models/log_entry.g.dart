// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LogEntry _$LogEntryFromJson(Map<String, dynamic> json) => _LogEntry(
  id: json['id'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  level: $enumDecode(_$LogLevelEnumMap, json['level']),
  category: $enumDecode(_$LogCategoryEnumMap, json['category']),
  message: json['message'] as String,
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$LogEntryToJson(_LogEntry instance) => <String, dynamic>{
  'id': instance.id,
  'timestamp': instance.timestamp.toIso8601String(),
  'level': _$LogLevelEnumMap[instance.level]!,
  'category': _$LogCategoryEnumMap[instance.category]!,
  'message': instance.message,
  'metadata': instance.metadata,
};

const _$LogLevelEnumMap = {
  LogLevel.debug: 'debug',
  LogLevel.info: 'info',
  LogLevel.warning: 'warning',
  LogLevel.error: 'error',
};

const _$LogCategoryEnumMap = {
  LogCategory.connection: 'connection',
  LogCategory.tool: 'tool',
  LogCategory.resource: 'resource',
  LogCategory.prompt: 'prompt',
  LogCategory.system: 'system',
};
