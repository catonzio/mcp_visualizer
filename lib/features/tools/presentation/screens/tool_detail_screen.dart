import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mcp_visualizer/core/utils/json_input_field.dart';
import 'package:mcp_visualizer/features/tools/domain/models/tool_model.dart';
import 'package:mcp_visualizer/features/tools/presentation/providers/tools_providers.dart';
import 'package:go_router/go_router.dart';
import 'package:mcp_visualizer/features/tools/presentation/widgets/input_schema_viewer.dart';

import 'package:mcp_visualizer/features/tools/presentation/widgets/tool_result_view.dart';
import 'package:mcp_visualizer/shared/widgets/error_view.dart';

class ToolDetailScreen extends ConsumerStatefulWidget {
  const ToolDetailScreen({
    super.key,
    required this.serverId,
    required this.toolName,
  });

  final String serverId;
  final String toolName;

  @override
  ConsumerState<ToolDetailScreen> createState() => _ToolDetailScreenState();
}

class _ToolDetailScreenState extends ConsumerState<ToolDetailScreen> {
  Map<String, dynamic>? _args;
  bool _schemaExpanded = false;

  @override
  Widget build(BuildContext context) {
    final toolsAsync = ref.watch(toolListProvider(widget.serverId));
    final executionState = ref.watch(
      toolExecutionNotifierProvider((
        serverId: widget.serverId,
        toolName: widget.toolName,
      )),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.toolName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: toolsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => ErrorView(
          message: err.toString(),
          onRetry: () => ref.invalidate(toolListProvider(widget.serverId)),
        ),
        data: (tools) {
          final tool = tools
              .where((t) => t.name == widget.toolName)
              .firstOrNull;
          if (tool == null) {
            return const ErrorView(message: 'Tool not found.');
          }
          return _Body(
            tool: tool,
            executionState: executionState,
            args: _args,
            schemaExpanded: _schemaExpanded,
            onSchemaToggled: () =>
                setState(() => _schemaExpanded = !_schemaExpanded),
            onArgsChanged: (v) => setState(() => _args = v),
            onExecute: _execute,
            onCancel: _cancel,
            onReset: _reset,
          );
        },
      ),
    );
  }

  Future<void> _execute() async {
    await ref
        .read(
          toolExecutionNotifierProvider((
            serverId: widget.serverId,
            toolName: widget.toolName,
          )).notifier,
        )
        .execute(_args ?? {});
  }

  Future<void> _cancel() async {
    await ref
        .read(
          toolExecutionNotifierProvider((
            serverId: widget.serverId,
            toolName: widget.toolName,
          )).notifier,
        )
        .cancel();
  }

  void _reset() {
    ref
        .read(
          toolExecutionNotifierProvider((
            serverId: widget.serverId,
            toolName: widget.toolName,
          )).notifier,
        )
        .reset();
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.tool,
    required this.executionState,
    required this.args,
    required this.schemaExpanded,
    required this.onSchemaToggled,
    required this.onArgsChanged,
    required this.onExecute,
    required this.onCancel,
    required this.onReset,
  });

  final ToolModel tool;
  final ToolExecutionState executionState;
  final Map<String, dynamic>? args;
  final bool schemaExpanded;
  final VoidCallback onSchemaToggled;
  final void Function(Map<String, dynamic>?) onArgsChanged;
  final VoidCallback onExecute;
  final VoidCallback onCancel;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          if (tool.description.isNotEmpty) ...[
            Text(tool.description, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16),
          ],

          // Collapsible schema viewer
          Card(
            child: ExpansionTile(
              initiallyExpanded: schemaExpanded,
              onExpansionChanged: (_) => onSchemaToggled(),
              title: Text('Input Schema', style: theme.textTheme.titleSmall),
              leading: const Icon(Icons.schema_outlined),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: InputSchemaViewer(schema: tool.inputSchema),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // JSON arguments input
          JsonInputField(onChanged: onArgsChanged),
          const SizedBox(height: 16),

          // Execute / Cancel button
          Row(
            children: [
              FilledButton.icon(
                onPressed: executionState.isLoading ? null : onExecute,
                icon: executionState.isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.play_arrow),
                label: Text(executionState.isLoading ? 'Running…' : 'Execute'),
              ),
              if (executionState.isLoading) ...[
                const SizedBox(width: 8),
                TextButton(onPressed: onCancel, child: const Text('Cancel')),
              ],
              if (!executionState.isLoading &&
                  (executionState.result != null ||
                      executionState.error != null)) ...[
                const SizedBox(width: 8),
                TextButton(onPressed: onReset, child: const Text('Clear')),
              ],
            ],
          ),
          const SizedBox(height: 16),

          // Error from execution
          if (executionState.error != null)
            Card(
              color: theme.colorScheme.errorContainer,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: theme.colorScheme.error),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        executionState.error!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Tool result
          if (executionState.result != null)
            ToolResultView(results: executionState.result!),
        ],
      ),
    );
  }
}
