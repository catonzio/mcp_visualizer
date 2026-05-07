import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mcp_visualizer/core/theme/app_theme.dart';
import 'package:mcp_visualizer/core/utils/platform_utils.dart';
import 'package:mcp_visualizer/features/event_log/presentation/screens/event_log_screen.dart';
import 'package:mcp_visualizer/features/prompts/presentation/screens/prompt_detail_screen.dart';
import 'package:mcp_visualizer/features/prompts/presentation/screens/prompts_screen.dart';
import 'package:mcp_visualizer/features/resources/presentation/screens/resource_detail_screen.dart';
import 'package:mcp_visualizer/features/resources/presentation/screens/resources_screen.dart';
import 'package:mcp_visualizer/features/connection/presentation/screens/connection_screen.dart';
import 'package:mcp_visualizer/features/servers/presentation/screens/server_form_screen.dart';
import 'package:mcp_visualizer/features/servers/presentation/screens/server_list_screen.dart';
import 'package:mcp_visualizer/features/tools/presentation/screens/tool_detail_screen.dart';
import 'package:mcp_visualizer/features/tools/presentation/screens/tools_screen.dart';

// ---------------------------------------------------------------------------
// Navigation destinations configuration
// ---------------------------------------------------------------------------

const _destinations = [
  _NavDest(
    label: 'Servers',
    icon: Icons.storage_outlined,
    selectedIcon: Icons.storage,
    rootPath: '/',
  ),
  _NavDest(
    label: 'Tools',
    icon: Icons.handyman_outlined,
    selectedIcon: Icons.handyman,
    rootPath: '/tools',
  ),
  _NavDest(
    label: 'Resources',
    icon: Icons.folder_outlined,
    selectedIcon: Icons.folder,
    rootPath: '/resources',
  ),
  _NavDest(
    label: 'Prompts',
    icon: Icons.chat_bubble_outline,
    selectedIcon: Icons.chat_bubble,
    rootPath: '/prompts',
  ),
  _NavDest(
    label: 'Log',
    icon: Icons.receipt_long_outlined,
    selectedIcon: Icons.receipt_long,
    rootPath: '/log',
  ),
];

@immutable
class _NavDest {
  const _NavDest({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.rootPath,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final String rootPath;
}

// ---------------------------------------------------------------------------
// Router
// ---------------------------------------------------------------------------

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          _AppShell(navigationShell: navigationShell),
      branches: [
        // ── Servers ──────────────────────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              name: 'serverList',
              builder: (context, state) => const ServerListScreen(),
              routes: [
                GoRoute(
                  path: 'servers/add',
                  name: 'serverAdd',
                  builder: (context, state) => const ServerFormScreen(),
                ),
                GoRoute(
                  path: 'servers/:id/edit',
                  name: 'serverEdit',
                  builder: (context, state) =>
                      ServerFormScreen(profileId: state.pathParameters['id']),
                ),
                GoRoute(
                  path: 'servers/:id/connect',
                  name: 'serverConnect',
                  builder: (context, state) =>
                      ConnectionScreen(profileId: state.pathParameters['id']!),
                ),
              ],
            ),
          ],
        ),

        // ── Tools ────────────────────────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tools',
              name: 'toolList',
              builder: (context, state) => const ToolsScreen(),
              routes: [
                GoRoute(
                  path: ':name',
                  name: 'toolDetail',
                  builder: (context, state) => ToolDetailScreen(
                    toolName: Uri.decodeComponent(
                      state.pathParameters['name']!,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        // ── Resources ────────────────────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/resources',
              name: 'resourceList',
              builder: (context, state) => const ResourcesScreen(),
              routes: [
                GoRoute(
                  path: 'detail',
                  name: 'resourceDetail',
                  builder: (context, state) =>
                      ResourceDetailScreen(uri: state.extra as String),
                ),
              ],
            ),
          ],
        ),

        // ── Prompts ──────────────────────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/prompts',
              name: 'promptList',
              builder: (context, state) => const PromptsScreen(),
              routes: [
                GoRoute(
                  path: ':name',
                  name: 'promptDetail',
                  builder: (context, state) => PromptDetailScreen(
                    promptName: Uri.decodeComponent(
                      state.pathParameters['name']!,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        // ── Event Log ────────────────────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/log',
              name: 'eventLog',
              builder: (context, state) => const EventLogScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

// ---------------------------------------------------------------------------
// App shell with adaptive navigation
// ---------------------------------------------------------------------------

class _AppShell extends StatelessWidget {
  const _AppShell({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final isDesktop = PlatformUtils.isDesktop;

    if (isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _onDestinationSelected,
              labelType: NavigationRailLabelType.all,
              destinations: _destinations
                  .map(
                    (d) => NavigationRailDestination(
                      icon: Icon(d.icon),
                      selectedIcon: Icon(d.selectedIcon),
                      label: Text(d.label),
                    ),
                  )
                  .toList(),
            ),
            const VerticalDivider(width: 1),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: _destinations
            .map(
              (d) => NavigationDestination(
                icon: Icon(d.icon),
                selectedIcon: Icon(d.selectedIcon),
                label: d.label,
              ),
            )
            .toList(),
      ),
    );
  }

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

// ---------------------------------------------------------------------------
// App widget
// ---------------------------------------------------------------------------

class McpVisualizerApp extends StatelessWidget {
  const McpVisualizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MCP Visualizer',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
