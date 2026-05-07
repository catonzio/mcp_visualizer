import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mcp_visualizer/core/router/app_routes.dart';
import 'package:mcp_visualizer/features/resources/presentation/providers/resources_providers.dart';
import 'package:mcp_visualizer/shared/widgets/empty_state.dart';
import 'package:mcp_visualizer/shared/widgets/error_view.dart';

class ResourcesScreen extends ConsumerStatefulWidget {
  const ResourcesScreen({super.key, required this.serverId});

  final String serverId;

  @override
  ConsumerState<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends ConsumerState<ResourcesScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resourcesAsync = ref.watch(resourceListProvider(widget.serverId));
    final updatedUris = ref.watch(resourceUpdateProvider(widget.serverId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resources'),
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search resources…',
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
      body: resourcesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => ErrorView(
          message: err.toString(),
          onRetry: () => ref.invalidate(resourceListProvider(widget.serverId)),
        ),
        data: (resources) {
          final filtered = _query.isEmpty
              ? resources
              : resources
                    .where(
                      (r) =>
                          r.name.toLowerCase().contains(_query.toLowerCase()) ||
                          r.uri.toLowerCase().contains(_query.toLowerCase()) ||
                          r.description.toLowerCase().contains(
                            _query.toLowerCase(),
                          ),
                    )
                    .toList();

          if (filtered.isEmpty) {
            return EmptyState(
              icon: Icons.folder_open_outlined,
              message: resources.isEmpty
                  ? 'No resources exposed by this server.'
                  : 'No resources match "$_query".',
            );
          }

          return RefreshIndicator(
            onRefresh: () async =>
                ref.invalidate(resourceListProvider(widget.serverId)),
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final resource = filtered[i];
                final isUpdated = updatedUris.contains(resource.uri);
                return ListTile(
                  leading: isUpdated
                      ? const Badge(
                          label: Text('updated'),
                          child: Icon(Icons.description_outlined),
                        )
                      : const Icon(Icons.description_outlined),
                  title: Text(
                    resource.name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resource.uri,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      if (resource.description.isNotEmpty)
                        Text(
                          resource.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(fontFamily: null),
                        ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (resource.mimeType != null)
                        Chip(
                          label: Text(
                            resource.mimeType!,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          visualDensity: VisualDensity.compact,
                        ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: () {
                    if (isUpdated) {
                      ref
                          .read(
                            resourceUpdateProvider(widget.serverId).notifier,
                          )
                          .markSeen(resource.uri);
                    }
                    context.push(
                      AppRoutes.resourceDetail(widget.serverId),
                      extra: resource.uri,
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
