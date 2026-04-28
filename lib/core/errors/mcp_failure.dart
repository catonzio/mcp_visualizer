import 'package:freezed_annotation/freezed_annotation.dart';

part 'mcp_failure.freezed.dart';

@freezed
sealed class McpFailure with _$McpFailure {
  const factory McpFailure.network({required String message, Object? cause}) =
      NetworkFailure;

  const factory McpFailure.transport({required String message, Object? cause}) =
      TransportFailure;

  const factory McpFailure.protocol({
    required String message,
    int? code,
    Object? cause,
  }) = ProtocolFailure;

  const factory McpFailure.serialization({
    required String message,
    Object? cause,
  }) = SerializationFailure;

  const factory McpFailure.unknown({required String message, Object? cause}) =
      UnknownFailure;
}

extension McpFailureX on McpFailure {
  String get userMessage => switch (this) {
    NetworkFailure(:final message) => 'Network error: $message',
    TransportFailure(:final message) => 'Transport error: $message',
    ProtocolFailure(:final message) => 'Protocol error: $message',
    SerializationFailure(:final message) => 'Serialization error: $message',
    UnknownFailure(:final message) => 'Unexpected error: $message',
  };
}
