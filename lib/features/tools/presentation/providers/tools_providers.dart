import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mcp_client/mcp_client.dart'
    hide ServerInfo, Disconnected, Connecting, Connected, ConnectionError;

import 'package:mcp_visualizer/features/connection/presentation/providers/mcp_client_provider.dart';
import 'package:mcp_visualizer/features/tools/domain/models/tool_model.dart';
import 'package:mcp_visualizer/features/tools/domain/models/tool_result_model.dart';

// ---------------------------------------------------------------------------
// Tool list
// ---------------------------------------------------------------------------

/// Fetches the list of tools from the connected MCP server.
/// Returns an empty list when not connected.
final toolListProvider = FutureProvider<List<ToolModel>>((ref) async {
  final client = ref.watch(mcpClientProvider);
  if (client == null) return [];

  final tools = await client.listTools();
  return tools
      .map(
        (t) => ToolModel(
          name: t.name,
          description: t.description,
          inputSchema: t.inputSchema,
        ),
      )
      .toList();
});

// ---------------------------------------------------------------------------
// Tool execution
// ---------------------------------------------------------------------------

/// State for a single tool execution.
class ToolExecutionState {
  const ToolExecutionState({
    this.result,
    this.isLoading = false,
    this.error,
    this.operationId,
  });

  final List<ToolResultModel>? result;
  final bool isLoading;
  final String? error;
  final String? operationId;

  ToolExecutionState copyWith({
    List<ToolResultModel>? result,
    bool? isLoading,
    String? error,
    String? operationId,
    bool clearResult = false,
    bool clearError = false,
    bool clearOperationId = false,
  }) {
    return ToolExecutionState(
      result: clearResult ? null : result ?? this.result,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error ?? this.error,
      operationId: clearOperationId ? null : operationId ?? this.operationId,
    );
  }
}

class ToolExecutionNotifier extends Notifier<ToolExecutionState> {
  ToolExecutionNotifier(this._toolName);

  final String _toolName;

  @override
  ToolExecutionState build() => const ToolExecutionState();

  Future<void> execute(Map<String, dynamic> args) async {
    final client = ref.read(mcpClientProvider);
    if (client == null) {
      state = state.copyWith(
        isLoading: false,
        error: 'Not connected to a server.',
        clearResult: true,
      );
      return;
    }

    state = state.copyWith(
      isLoading: true,
      clearResult: true,
      clearError: true,
      clearOperationId: true,
    );

    try {
      final tracking = await client.callToolWithTracking(_toolName, args);
      final operationId = tracking.operationId;
      final callResult = tracking.result;

      final results = _mapContent(callResult);

      state = state.copyWith(
        isLoading: false,
        result: results,
        operationId: operationId,
        clearError: true,
      );
    } on McpError catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
        clearResult: true,
        clearOperationId: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        clearResult: true,
        clearOperationId: true,
      );
    }
  }

  Future<void> cancel() async {
    final opId = state.operationId;
    if (opId == null) return;
    final client = ref.read(mcpClientProvider);
    if (client == null) return;
    try {
      await client.cancelOperation(opId);
    } catch (_) {
      // Ignore cancel errors
    } finally {
      state = state.copyWith(isLoading: false, clearOperationId: true);
    }
  }

  void reset() {
    state = const ToolExecutionState();
  }

  List<ToolResultModel> _mapContent(CallToolResult result) {
    return result.content.map((content) {
      if (content is TextContent) {
        return ToolResultModel.text(value: content.text);
      } else if (content is ImageContent) {
        return ToolResultModel.image(
          data: content.data,
          url: content.url,
          mimeType: content.mimeType,
        );
      } else {
        return const ToolResultModel.text(value: '[unsupported content type]');
      }
    }).toList();
  }
}

final toolExecutionNotifierProvider =
    NotifierProvider.family<ToolExecutionNotifier, ToolExecutionState, String>(
      (toolName) => ToolExecutionNotifier(toolName),
    );
