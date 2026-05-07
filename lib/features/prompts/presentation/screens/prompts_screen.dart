import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mcp_visualizer/core/router/app_routes.dart';
import 'package:mcp_visualizer/features/prompts/presentation/providers/prompts_providers.dart';
import 'package:mcp_visualizer/shared/widgets/empty_state.dart';
import 'package:mcp_visualizer/shared/widgets/error_view.dart';

class PromptsScreen extends ConsumerStatefulWidget {
  const PromptsScreen({super.key, required this.serverId});

  final String serverId;

  @override
  ConsumerState<PromptsScreen> createState() => _PromptsScreenState();
}

class _PromptsScreenState extends ConsumerState<PromptsScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final promptsAsync = ref.watch(promptListProvider(widget.serverId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prompts'),
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search prompts…',
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
      body: promptsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => ErrorView(
          message: err.toString(),
          onRetry: () => ref.invalidate(promptListProvider(widget.serverId)),
        ),
        data: (prompts) {
          final filtered = _query.isEmpty
              ? prompts
              : prompts
                    .where(
                      (p) =>
                          p.name.toLowerCase().contains(_query.toLowerCase()) ||
                          (p.description ?? '').toLowerCase().contains(
                            _query.toLowerCase(),
                          ),
                    )
                    .toList();

          if (filtered.isEmpty) {
            return EmptyState(
              icon: Icons.chat_bubble_outline,
              message: prompts.isEmpty
                  ? 'No prompts exposed by this server.'
                  : 'No prompts match "$_query".',
            );
          }

          return RefreshIndicator(
            onRefresh: () async =>
                ref.invalidate(promptListProvider(widget.serverId)),
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final prompt = filtered[i];
                return ListTile(
                  title: Text(
                    prompt.name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: prompt.description != null
                      ? Text(
                          prompt.description!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (prompt.arguments.isNotEmpty)
                        Chip(
                          label: Text(
                            '${prompt.arguments.length} args',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          visualDensity: VisualDensity.compact,
                        ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: () => context.push(
                    AppRoutes.promptDetail(widget.serverId, prompt.name),
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
