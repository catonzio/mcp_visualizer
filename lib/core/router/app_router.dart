import 'package:go_router/go_router.dart';

import 'package:mcp_visualizer/core/router/app_routes.dart';
import 'package:mcp_visualizer/features/event_log/presentation/screens/event_log_screen.dart';
import 'package:mcp_visualizer/features/prompts/presentation/screens/prompt_detail_screen.dart';
import 'package:mcp_visualizer/features/prompts/presentation/screens/prompts_screen.dart';
import 'package:mcp_visualizer/features/resources/presentation/screens/resource_detail_screen.dart';
import 'package:mcp_visualizer/features/resources/presentation/screens/resources_screen.dart';
import 'package:mcp_visualizer/features/servers/presentation/screens/server_form_screen.dart';
import 'package:mcp_visualizer/features/servers/presentation/screens/server_list_screen.dart';
import 'package:mcp_visualizer/features/servers/presentation/screens/server_workspace_screen.dart';
import 'package:mcp_visualizer/features/tools/presentation/screens/tool_detail_screen.dart';
import 'package:mcp_visualizer/features/tools/presentation/screens/tools_screen.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.serverListPath,
  routes: [
    // ── Server list (home) ──────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.serverListPath,
      name: AppRoutes.serverListName,
      builder: (context, state) => const ServerListScreen(),
      routes: [
        // Server form screens live outside the workspace shell.
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
      ],
    ),

    // ── Workspace shell ─────────────────────────────────────────────────
    // The shell keeps the AppBar + NavigationRail alive while swapping
    // only the body as the user navigates between tabs / detail pages.
    ShellRoute(
      builder: (context, state, child) {
        // Extract serverId from the URI: /servers/<id>/...
        final segments = state.uri.pathSegments;
        final serverId = segments.length >= 2 ? segments[1] : '';
        return ServerWorkspaceShell(
          serverId: serverId,
          location: state.uri.path,
          child: child,
        );
      },
      routes: [
        // /servers/:id  →  redirect to tools tab
        GoRoute(
          path: '/servers/:id',
          redirect: (context, state) =>
              AppRoutes.toolsList(state.pathParameters['id']!),
        ),

        // Tools list
        GoRoute(
          path: AppRoutes.toolsTabPath,
          pageBuilder: (context, state) => NoTransitionPage(
            child: ToolsScreen(serverId: state.pathParameters['id']!),
          ),
        ),
        // Tool detail
        GoRoute(
          path: AppRoutes.toolDetailPath,
          pageBuilder: (context, state) => NoTransitionPage(
            child: ToolDetailScreen(
              serverId: state.pathParameters['id']!,
              toolName: Uri.decodeComponent(state.pathParameters['name']!),
            ),
          ),
        ),

        // Resources list
        GoRoute(
          path: AppRoutes.resourcesTabPath,
          pageBuilder: (context, state) => NoTransitionPage(
            child: ResourcesScreen(serverId: state.pathParameters['id']!),
          ),
        ),
        // Resource detail  (uri passed via extra)
        GoRoute(
          path: AppRoutes.resourceDetailPath,
          pageBuilder: (context, state) => NoTransitionPage(
            child: ResourceDetailScreen(
              serverId: state.pathParameters['id']!,
              uri: state.extra as String,
            ),
          ),
        ),

        // Prompts list
        GoRoute(
          path: AppRoutes.promptsTabPath,
          pageBuilder: (context, state) => NoTransitionPage(
            child: PromptsScreen(serverId: state.pathParameters['id']!),
          ),
        ),
        // Prompt detail
        GoRoute(
          path: AppRoutes.promptDetailPath,
          pageBuilder: (context, state) => NoTransitionPage(
            child: PromptDetailScreen(
              serverId: state.pathParameters['id']!,
              promptName: Uri.decodeComponent(state.pathParameters['name']!),
            ),
          ),
        ),

        // Event log
        GoRoute(
          path: AppRoutes.logTabPath,
          pageBuilder: (context, state) => NoTransitionPage(
            child: EventLogScreen(serverId: state.pathParameters['id']!),
          ),
        ),
      ],
    ),
  ],
);
