import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mcp_visualizer/core/utils/platform_utils.dart';
import 'package:mcp_visualizer/features/connection/presentation/providers/mcp_client_provider.dart';
import 'package:mcp_visualizer/features/connection/presentation/widgets/connection_status_badge.dart';
import 'package:mcp_visualizer/features/event_log/presentation/screens/event_log_screen.dart';
import 'package:mcp_visualizer/features/prompts/presentation/screens/prompts_screen.dart';
import 'package:mcp_visualizer/features/resources/presentation/screens/resources_screen.dart';
import 'package:mcp_visualizer/features/servers/presentation/providers/server_profile_providers.dart';
import 'package:mcp_visualizer/features/tools/presentation/screens/tools_screen.dart';

// ---------------------------------------------------------------------------
// Workspace screen — per-server shell with NavigationRail / NavigationBar
// ---------------------------------------------------------------------------

class ServerWorkspaceScreen extends ConsumerStatefulWidget {
  const ServerWorkspaceScreen({super.key, required this.serverId});

  final String serverId;

  @override
  ConsumerState<ServerWorkspaceScreen> createState() =>
      _ServerWorkspaceScreenState();
}

class _ServerWorkspaceScreenState extends ConsumerState<ServerWorkspaceScreen> {
  int _selectedIndex = 0;

  static const _tabs = [
    _TabDef(
      label: 'Tools',
      icon: Icons.handyman_outlined,
      selectedIcon: Icons.handyman,
    ),
    _TabDef(
      label: 'Resources',
      icon: Icons.folder_outlined,
      selectedIcon: Icons.folder,
    ),
    _TabDef(
      label: 'Prompts',
      icon: Icons.chat_bubble_outline,
      selectedIcon: Icons.chat_bubble,
    ),
    _TabDef(
      label: 'Log',
      icon: Icons.receipt_long_outlined,
      selectedIcon: Icons.receipt_long,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final profilesAsync = ref.watch(serverProfileNotifierProvider);
    final serverName =
        profilesAsync.asData?.value
            .where((p) => p.id == widget.serverId)
            .firstOrNull
            ?.name ??
        'Server';

    final body = IndexedStack(
      index: _selectedIndex,
      children: [
        ToolsScreen(serverId: widget.serverId),
        ResourcesScreen(serverId: widget.serverId),
        PromptsScreen(serverId: widget.serverId),
        EventLogScreen(serverId: widget.serverId),
      ],
    );

    final appBar = AppBar(
      title: Text(serverName),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        tooltip: 'Back to servers',
        onPressed: () => context.go('/'),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ConnectionStatusBadge(serverId: widget.serverId),
        ),
        IconButton(
          icon: const Icon(Icons.link_off),
          tooltip: 'Disconnect',
          onPressed: _disconnect,
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
              selectedIndex: _selectedIndex,
              onDestinationSelected: (i) => setState(() => _selectedIndex = i),
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
            Expanded(child: body),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: appBar,
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
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

  Future<void> _disconnect() async {
    await ref
        .read(mcpClientNotifierProvider(widget.serverId).notifier)
        .disconnect();
    if (mounted) context.go('/');
  }
}

@immutable
class _TabDef {
  const _TabDef({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}
