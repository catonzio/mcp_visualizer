import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mcp_visualizer/core/utils/json_input_field.dart';
import 'package:mcp_visualizer/features/prompts/presentation/providers/prompts_providers.dart';
import 'package:mcp_visualizer/features/prompts/presentation/widgets/prompt_message_view.dart';
import 'package:go_router/go_router.dart';

import 'package:mcp_visualizer/shared/widgets/error_view.dart';

class PromptDetailScreen extends ConsumerStatefulWidget {
  const PromptDetailScreen({
    super.key,
    required this.serverId,
    required this.promptName,
  });

  final String serverId;
  final String promptName;

  @override
  ConsumerState<PromptDetailScreen> createState() => _PromptDetailScreenState();
}

class _PromptDetailScreenState extends ConsumerState<PromptDetailScreen> {
  Map<String, dynamic>? _args;

  @override
  Widget build(BuildContext context) {
    final promptsAsync = ref.watch(promptListProvider(widget.serverId));
    final execState = ref.watch(
      promptGetNotifierProvider((
        serverId: widget.serverId,
        promptName: widget.promptName,
      )),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.promptName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              context.pop(),
        ),
      ),
      body: promptsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => ErrorView(
          message: err.toString(),
          onRetry: () => ref.invalidate(promptListProvider(widget.serverId)),
        ),
        data: (prompts) {
          final prompt = prompts
              .where((p) => p.name == widget.promptName)
              .firstOrNull;
          if (prompt == null) {
            return const ErrorView(message: 'Prompt not found.');
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description
                if (prompt.description != null &&
                    prompt.description!.isNotEmpty) ...[
                  Text(
                    prompt.description!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                ],

                // Arguments list
                if (prompt.arguments.isNotEmpty) ...[
                  Text(
                    'Arguments',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  ...prompt.arguments.map(
                    (arg) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Chip(
                            label: Text(
                              arg.required ? 'required' : 'optional',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            backgroundColor: arg.required
                                ? Theme.of(context).colorScheme.primaryContainer
                                : null,
                            visualDensity: VisualDensity.compact,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  arg.name,
                                  style: Theme.of(context).textTheme.labelMedium
                                      ?.copyWith(
                                        fontFamily: 'monospace',
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                if (arg.description != null)
                                  Text(
                                    arg.description!,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // JSON arguments input
                JsonInputField(
                  label: 'Arguments (JSON)',
                  onChanged: (v) => setState(() => _args = v),
                ),
                const SizedBox(height: 16),

                // Action buttons
                Row(
                  children: [
                    FilledButton.icon(
                      onPressed: execState.isLoading ? null : _getPrompt,
                      icon: execState.isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.send_outlined),
                      label: Text(
                        execState.isLoading ? 'Fetching…' : 'Get Prompt',
                      ),
                    ),
                    if (!execState.isLoading && execState.messages != null) ...[
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () => ref
                            .read(
                              promptGetNotifierProvider((
                                serverId: widget.serverId,
                                promptName: widget.promptName,
                              )).notifier,
                            )
                            .reset(),
                        child: const Text('Clear'),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16),

                // Execution error
                if (execState.error != null)
                  Card(
                    color: Theme.of(context).colorScheme.errorContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              execState.error!,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onErrorContainer,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Message result
                if (execState.messages != null) ...[
                  if (execState.description != null) ...[
                    Text(
                      execState.description!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  PromptMessageView(messages: execState.messages!),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _getPrompt() async {
    await ref
        .read(
          promptGetNotifierProvider((
            serverId: widget.serverId,
            promptName: widget.promptName,
          )).notifier,
        )
        .get(_args ?? {});
  }
}
