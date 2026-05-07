import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mcp_visualizer/core/router/app_routes.dart';
import 'package:mcp_visualizer/features/tools/presentation/providers/tools_providers.dart';
import 'package:mcp_visualizer/features/tools/presentation/widgets/tool_list_tile.dart';
import 'package:mcp_visualizer/shared/widgets/empty_state.dart';
import 'package:mcp_visualizer/shared/widgets/error_view.dart';

class ToolsScreen extends ConsumerStatefulWidget {
  const ToolsScreen({super.key, required this.serverId});

  final String serverId;

  @override
  ConsumerState<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends ConsumerState<ToolsScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final toolsAsync = ref.watch(toolListProvider(widget.serverId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tools'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search tools…',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
                isDense: true,
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
        ),
      ),
      body: toolsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => ErrorView(
          message: err.toString(),
          onRetry: () => ref.invalidate(toolListProvider(widget.serverId)),
        ),
        data: (tools) {
          final filtered = _query.isEmpty
              ? tools
              : tools
                    .where(
                      (t) =>
                          t.name.toLowerCase().contains(_query.toLowerCase()) ||
                          t.description.toLowerCase().contains(
                            _query.toLowerCase(),
                          ),
                    )
                    .toList();

          if (filtered.isEmpty) {
            return EmptyState(
              icon: Icons.handyman_outlined,
              message: tools.isEmpty
                  ? 'No tools exposed by this server.'
                  : 'No tools match "$_query".',
            );
          }

          return RefreshIndicator(
            onRefresh: () async =>
                ref.invalidate(toolListProvider(widget.serverId)),
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final tool = filtered[i];
                return ToolListTile(
                  tool: tool,
                  onTap: () => context.push(
                    AppRoutes.toolDetail(widget.serverId, tool.name),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
