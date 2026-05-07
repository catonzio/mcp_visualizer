import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mcp_visualizer/core/theme/app_theme.dart';
import 'package:mcp_visualizer/features/prompts/presentation/screens/prompt_detail_screen.dart';
import 'package:mcp_visualizer/features/resources/presentation/screens/resource_detail_screen.dart';
import 'package:mcp_visualizer/features/servers/presentation/screens/server_form_screen.dart';
import 'package:mcp_visualizer/features/servers/presentation/screens/server_list_screen.dart';
import 'package:mcp_visualizer/features/servers/presentation/screens/server_workspace_screen.dart';
import 'package:mcp_visualizer/features/tools/presentation/screens/tool_detail_screen.dart';

// ---------------------------------------------------------------------------
// Router
// ---------------------------------------------------------------------------

final _router = GoRouter(
  initialLocation: '/',
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
          path: 'servers/:id',
          name: 'serverWorkspace',
          builder: (context, state) =>
              ServerWorkspaceScreen(serverId: state.pathParameters['id']!),
          routes: [
            GoRoute(
              path: 'tools/:name',
              name: 'toolDetail',
              builder: (context, state) => ToolDetailScreen(
                serverId: state.pathParameters['id']!,
                toolName: Uri.decodeComponent(state.pathParameters['name']!),
              ),
            ),
            GoRoute(
              path: 'resources/detail',
              name: 'resourceDetail',
              builder: (context, state) => ResourceDetailScreen(
                serverId: state.pathParameters['id']!,
                uri: state.extra as String,
              ),
            ),
            GoRoute(
              path: 'prompts/:name',
              name: 'promptDetail',
              builder: (context, state) => PromptDetailScreen(
                serverId: state.pathParameters['id']!,
                promptName: Uri.decodeComponent(state.pathParameters['name']!),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

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
