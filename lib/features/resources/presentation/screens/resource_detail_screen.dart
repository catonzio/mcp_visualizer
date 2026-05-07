import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mcp_visualizer/features/resources/presentation/providers/resources_providers.dart';
import 'package:mcp_visualizer/features/resources/presentation/widgets/resource_content_viewer.dart';
import 'package:mcp_visualizer/shared/widgets/error_view.dart';

class ResourceDetailScreen extends ConsumerWidget {
  const ResourceDetailScreen({
    super.key,
    required this.serverId,
    required this.uri,
  });

  final String serverId;
  final String uri;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentAsync = ref.watch(
      resourceContentProvider((serverId: serverId, uri: uri)),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(uri, overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () => ref.invalidate(
              resourceContentProvider((serverId: serverId, uri: uri)),
            ),
          ),
        ],
      ),
      body: contentAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => ErrorView(
          message: err.toString(),
          onRetry: () => ref.invalidate(
            resourceContentProvider((serverId: serverId, uri: uri)),
          ),
        ),
        data: (content) {
          if (content == null) {
            return const ErrorView(
              message: 'No content returned for this resource.',
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // URI header
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const Icon(Icons.link, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SelectableText(
                            uri,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(fontFamily: 'monospace'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Content viewer
                ResourceContentViewer(
                  uri: uri,
                  mimeType: content.mimeType,
                  text: content.text,
                  blob: content.blob,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
