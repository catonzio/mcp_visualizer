import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mcp_visualizer/core/theme/app_theme.dart';
import 'package:mcp_visualizer/features/servers/presentation/screens/server_form_screen.dart';
import 'package:mcp_visualizer/features/servers/presentation/screens/server_list_screen.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'serverList',
      builder: (context, state) => const ServerListScreen(),
    ),
    GoRoute(
      path: '/servers/add',
      name: 'serverAdd',
      builder: (context, state) => const ServerFormScreen(),
    ),
    GoRoute(
      path: '/servers/:id/edit',
      name: 'serverEdit',
      builder: (context, state) =>
          ServerFormScreen(profileId: state.pathParameters['id']),
    ),
    GoRoute(
      path: '/servers/:id/connect',
      name: 'serverConnect',
      builder: (context, state) =>
          _PlaceholderScreen(title: 'Connect ${state.pathParameters['id']}'),
    ),
  ],
);

class McpVisualizerApp extends StatelessWidget {
  const McpVisualizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MCP Visualizer',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: _router,
    );
  }
}

// Temporary placeholder — replaced in later phases
class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(title, style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}
