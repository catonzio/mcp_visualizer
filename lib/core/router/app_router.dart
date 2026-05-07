import 'package:go_router/go_router.dart';

import 'package:mcp_visualizer/core/router/app_routes.dart';
import 'package:mcp_visualizer/features/prompts/presentation/screens/prompt_detail_screen.dart';
import 'package:mcp_visualizer/features/resources/presentation/screens/resource_detail_screen.dart';
import 'package:mcp_visualizer/features/servers/presentation/screens/server_form_screen.dart';
import 'package:mcp_visualizer/features/servers/presentation/screens/server_list_screen.dart';
import 'package:mcp_visualizer/features/servers/presentation/screens/server_workspace_screen.dart';
import 'package:mcp_visualizer/features/tools/presentation/screens/tool_detail_screen.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.serverListPath,
  routes: [
    GoRoute(
      path: AppRoutes.serverListPath,
      name: AppRoutes.serverListName,
      builder: (context, state) => const ServerListScreen(),
      routes: [
        GoRoute(
          path: AppRoutes.serverAddPath,
          name: AppRoutes.serverAddName,
          builder: (context, state) => const ServerFormScreen(),
        ),
        GoRoute(
          path: AppRoutes.serverEditPath,
          name: AppRoutes.serverEditName,
          builder: (context, state) =>
              ServerFormScreen(profileId: state.pathParameters['id']),
        ),
        GoRoute(
          path: AppRoutes.serverWorkspacePath,
          name: AppRoutes.serverWorkspaceName,
          builder: (context, state) =>
              ServerWorkspaceScreen(serverId: state.pathParameters['id']!),
          routes: [
            GoRoute(
              path: AppRoutes.toolDetailPath,
              name: AppRoutes.toolDetailName,
              builder: (context, state) => ToolDetailScreen(
                serverId: state.pathParameters['id']!,
                toolName: Uri.decodeComponent(state.pathParameters['name']!),
              ),
            ),
            GoRoute(
              path: AppRoutes.resourceDetailPath,
              name: AppRoutes.resourceDetailName,
              builder: (context, state) => ResourceDetailScreen(
                serverId: state.pathParameters['id']!,
                uri: state.extra as String,
              ),
            ),
            GoRoute(
              path: AppRoutes.promptDetailPath,
              name: AppRoutes.promptDetailName,
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
