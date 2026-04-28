import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:mcp_visualizer/core/errors/mcp_failure.dart';
import 'package:mcp_visualizer/features/connection/domain/models/server_info.dart';

part 'connection_state.freezed.dart';

@freezed
sealed class McpConnectionState with _$McpConnectionState {
  const factory McpConnectionState.disconnected() = Disconnected;
  const factory McpConnectionState.connecting() = Connecting;
  const factory McpConnectionState.connected({required ServerInfo serverInfo}) =
      Connected;
  const factory McpConnectionState.error({
    required McpFailure failure,
    @Default(0) int reconnectAttempts,
  }) = ConnectionError;
}
