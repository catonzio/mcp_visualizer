import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mcp_client/mcp_client.dart'
    hide ServerInfo, Disconnected, Connecting, Connected, ConnectionError;

import 'package:mcp_visualizer/features/connection/presentation/providers/mcp_client_provider.dart';
import 'package:mcp_visualizer/features/resources/domain/models/resource_model.dart';

// ---------------------------------------------------------------------------
// Resource list (family keyed by serverId)
// ---------------------------------------------------------------------------

final resourceListProvider = FutureProvider.family<List<ResourceModel>, String>(
  (ref, serverId) async {
    final client = ref.watch(mcpClientProvider(serverId));
    if (client == null) return [];

    final resources = await client.listResources();
    return resources
        .map(
          (r) => ResourceModel(
            uri: r.uri,
            name: r.name,
            description: r.description,
            mimeType: r.mimeType,
          ),
        )
        .toList();
  },
);

// ---------------------------------------------------------------------------
// Resource content (family keyed by ResourceKey = {serverId, uri})
// ---------------------------------------------------------------------------

typedef ResourceKey = ({String serverId, String uri});

final resourceContentProvider =
    FutureProvider.family<ResourceContentInfo?, ResourceKey>((ref, key) async {
      final client = ref.watch(mcpClientProvider(key.serverId));
      if (client == null) return null;

      final result = await client.readResource(key.uri);
      return result.contents.isNotEmpty ? result.contents.first : null;
    });

// ---------------------------------------------------------------------------
// Updated resource URIs (family keyed by serverId)
// ---------------------------------------------------------------------------

class ResourceUpdateNotifier extends Notifier<Set<String>> {
  ResourceUpdateNotifier(this.serverId);

  final String serverId;

  @override
  Set<String> build() {
    // Wire up the resource-updated callback whenever the client changes
    ref.listen(mcpClientProvider(serverId), (prev, next) {
      if (next == null || next == prev) return;
      next.onResourceUpdated((uri) {
        state = {...state, uri};
        // Invalidate the content cache so the detail screen refreshes
        ref.invalidate(resourceContentProvider((serverId: serverId, uri: uri)));
      });
    });
    return {};
  }

  void markSeen(String uri) {
    state = {...state}..remove(uri);
  }

  void clear() => state = {};
}

final resourceUpdateProvider =
    NotifierProvider.family<ResourceUpdateNotifier, Set<String>, String>(
      (serverId) => ResourceUpdateNotifier(serverId),
    );
