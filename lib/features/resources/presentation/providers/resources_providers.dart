import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mcp_client/mcp_client.dart'
    hide ServerInfo, Disconnected, Connecting, Connected, ConnectionError;

import 'package:mcp_visualizer/features/connection/presentation/providers/mcp_client_provider.dart';
import 'package:mcp_visualizer/features/resources/domain/models/resource_model.dart';

// ---------------------------------------------------------------------------
// Resource list
// ---------------------------------------------------------------------------

final resourceListProvider = FutureProvider<List<ResourceModel>>((ref) async {
  final client = ref.watch(mcpClientProvider);
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
});

// ---------------------------------------------------------------------------
// Resource content (family by URI)
// ---------------------------------------------------------------------------

final resourceContentProvider =
    FutureProvider.family<ResourceContentInfo?, String>((ref, uri) async {
      final client = ref.watch(mcpClientProvider);
      if (client == null) return null;

      final result = await client.readResource(uri);
      return result.contents.isNotEmpty ? result.contents.first : null;
    });

// ---------------------------------------------------------------------------
// Updated resource URIs — tracks which resources have received update notifications
// ---------------------------------------------------------------------------

class ResourceUpdateNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() {
    // Wire up the resource-updated callback whenever the client changes
    ref.listen(mcpClientProvider, (prev, next) {
      if (next == null || next == prev) return;
      next.onResourceUpdated((uri) {
        state = {...state, uri};
        // Invalidate the content cache so the detail screen refreshes
        ref.invalidate(resourceContentProvider(uri));
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
    NotifierProvider<ResourceUpdateNotifier, Set<String>>(
      ResourceUpdateNotifier.new,
    );
