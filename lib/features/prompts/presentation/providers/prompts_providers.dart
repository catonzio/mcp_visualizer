import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mcp_client/mcp_client.dart'
    hide ServerInfo, Disconnected, Connecting, Connected, ConnectionError;

import 'package:mcp_visualizer/features/connection/presentation/providers/mcp_client_provider.dart';
import 'package:mcp_visualizer/features/prompts/domain/models/prompt_model.dart';

// ---------------------------------------------------------------------------
// Prompt list
// ---------------------------------------------------------------------------

final promptListProvider = FutureProvider<List<PromptModel>>((ref) async {
  final client = ref.watch(mcpClientProvider);
  if (client == null) return [];

  final prompts = await client.listPrompts();
  return prompts
      .map(
        (p) => PromptModel(
          name: p.name,
          description: p.description,
          arguments: p.arguments
              .map(
                (a) => PromptArgumentModel(
                  name: a.name,
                  description: a.description,
                  required: a.required,
                  defaultValue: a.defaultValue,
                ),
              )
              .toList(),
        ),
      )
      .toList();
});

// ---------------------------------------------------------------------------
// Prompt execution state
// ---------------------------------------------------------------------------

class PromptExecutionState {
  const PromptExecutionState({
    this.messages,
    this.description,
    this.isLoading = false,
    this.error,
  });

  final List<Message>? messages;
  final String? description;
  final bool isLoading;
  final String? error;

  PromptExecutionState copyWith({
    List<Message>? messages,
    String? description,
    bool? isLoading,
    String? error,
    bool clearMessages = false,
    bool clearError = false,
  }) {
    return PromptExecutionState(
      messages: clearMessages ? null : messages ?? this.messages,
      description: description ?? this.description,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error ?? this.error,
    );
  }
}

class PromptGetNotifier extends Notifier<PromptExecutionState> {
  PromptGetNotifier(this._promptName);

  final String _promptName;

  @override
  PromptExecutionState build() => const PromptExecutionState();

  Future<void> get(Map<String, dynamic> args) async {
    final client = ref.read(mcpClientProvider);
    if (client == null) {
      state = state.copyWith(
        isLoading: false,
        error: 'Not connected to a server.',
        clearMessages: true,
      );
      return;
    }

    state = state.copyWith(
      isLoading: true,
      clearMessages: true,
      clearError: true,
    );

    try {
      final result = await client.getPrompt(_promptName, args);
      state = state.copyWith(
        isLoading: false,
        messages: result.messages,
        description: result.description,
        clearError: true,
      );
    } on McpError catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
        clearMessages: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        clearMessages: true,
      );
    }
  }

  void reset() => state = const PromptExecutionState();
}

final promptGetNotifierProvider =
    NotifierProvider.family<PromptGetNotifier, PromptExecutionState, String>(
      (promptName) => PromptGetNotifier(promptName),
    );
