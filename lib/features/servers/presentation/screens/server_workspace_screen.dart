import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mcp_visualizer/core/router/app_routes.dart';
import 'package:mcp_visualizer/core/utils/platform_utils.dart';
import 'package:mcp_visualizer/features/connection/presentation/providers/mcp_client_provider.dart';
import 'package:mcp_visualizer/features/connection/presentation/widgets/connection_status_badge.dart';
import 'package:mcp_visualizer/features/servers/presentation/providers/server_profile_providers.dart';

// ---------------------------------------------------------------------------
// Workspace shell — keeps AppBar + NavigationRail alive for all workspace
// routes. The router swaps only [child] when navigating between tabs and
// detail pages (using NoTransitionPage, so there is no slide animation).
// ---------------------------------------------------------------------------

class ServerWorkspaceShell extends ConsumerWidget {
  const ServerWorkspaceShell({
    super.key,
    required this.serverId,
    required this.location,
    required this.child,
  });

  final String serverId;

  /// Current matched URI path — used to highlight the correct rail destination.
  final String location;

  final Widget child;

  static const _tabs = [
    _TabDef(
      segment: 'tools',
      label: 'Tools',
      icon: Icons.handyman_outlined,
      selectedIcon: Icons.handyman,
    ),
    _TabDef(
      segment: 'resources',
      label: 'Resources',
      icon: Icons.folder_outlined,
      selectedIcon: Icons.folder,
    ),
    _TabDef(
      segment: 'prompts',
      label: 'Prompts',
      icon: Icons.chat_bubble_outline,
      selectedIcon: Icons.chat_bubble,
    ),
    _TabDef(
      segment: 'log',
      label: 'Log',
      icon: Icons.receipt_long_outlined,
      selectedIcon: Icons.receipt_long,
    ),
  ];

  int get _selectedIndex {
    if (location.contains('/resources')) return 1;
    if (location.contains('/prompts')) return 2;
    if (location.contains('/log')) return 3;
    return 0; // tools (default)
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilesAsync = ref.watch(serverProfileNotifierProvider);
    final serverName =
        profilesAsync.asData?.value
            .where((p) => p.id == serverId)
            .firstOrNull
            ?.name ??
        'Server';

    final selectedIndex = _selectedIndex;

    void onTabSelected(int i) {
      context.go('/servers/$serverId/${_tabs[i].segment}');
    }

    final appBar = AppBar(
      title: Text(serverName),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        tooltip: 'Back to servers',
        onPressed: () => context.go(AppRoutes.serverListPath),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ConnectionStatusBadge(serverId: serverId),
        ),
        IconButton(
          icon: const Icon(Icons.link_off),
          tooltip: 'Disconnect',
          onPressed: () async {
            await ref
                .read(mcpClientNotifierProvider(serverId).notifier)
                .disconnect();
            if (context.mounted) context.go(AppRoutes.serverListPath);
          },
        ),
        const SizedBox(width: 8),
      ],
    );

    if (PlatformUtils.isDesktop) {
      return Scaffold(
        appBar: appBar,
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: onTabSelected,
              labelType: NavigationRailLabelType.all,
              destinations: _tabs
                  .map(
                    (t) => NavigationRailDestination(
                      icon: Icon(t.icon),
                      selectedIcon: Icon(t.selectedIcon),
                      label: Text(t.label),
                    ),
                  )
                  .toList(),
            ),
            const VerticalDivider(width: 1),
            Expanded(child: child),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: appBar,
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onTabSelected,
        destinations: _tabs
            .map(
              (t) => NavigationDestination(
                icon: Icon(t.icon),
                selectedIcon: Icon(t.selectedIcon),
                label: t.label,
              ),
            )
            .toList(),
      ),
    );
  }
}

@immutable
class _TabDef {
  const _TabDef({
    required this.segment,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String segment;
  final String label;
  final IconData icon;
  final IconData selectedIcon;
}
