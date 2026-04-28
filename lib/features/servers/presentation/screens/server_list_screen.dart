import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mcp_visualizer/features/servers/domain/models/server_profile.dart';
import 'package:mcp_visualizer/features/servers/presentation/providers/server_profile_providers.dart';
import 'package:mcp_visualizer/features/servers/presentation/widgets/server_profile_card.dart';
import 'package:mcp_visualizer/shared/widgets/empty_state.dart';
import 'package:mcp_visualizer/shared/widgets/error_view.dart';

class ServerListScreen extends ConsumerWidget {
  const ServerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilesAsync = ref.watch(serverProfileNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('MCP Servers')),
      body: profilesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorView(
          message: 'Failed to load servers',
          description: e.toString(),
          onRetry: () => ref.invalidate(serverProfileNotifierProvider),
        ),
        data: (profiles) => profiles.isEmpty
            ? const EmptyState(
                icon: Icons.hub_outlined,
                message: 'No servers yet',
                description: 'Tap + to add an MCP server.',
              )
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: profiles.length,
                itemBuilder: (context, i) => ServerProfileCard(
                  profile: profiles[i],
                  onEdit: () => context.push('/servers/${profiles[i].id}/edit'),
                  onDelete: () => _confirmDelete(context, ref, profiles[i]),
                  onConnect: () =>
                      context.push('/servers/${profiles[i].id}/connect'),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/servers/add'),
        tooltip: 'Add server',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    ServerProfile profile,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete server?'),
        content: Text('Remove "${profile.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(serverProfileNotifierProvider.notifier).delete(profile.id);
    }
  }
}
