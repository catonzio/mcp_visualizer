import 'package:flutter/material.dart';

import 'package:mcp_visualizer/core/router/app_router.dart';
import 'package:mcp_visualizer/core/theme/app_theme.dart';

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
      routerConfig: appRouter,
    );
  }
}
