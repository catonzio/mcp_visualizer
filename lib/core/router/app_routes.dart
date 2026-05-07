/// Route name and path constants for the app.
abstract final class AppRoutes {
  // ── Server list (home) ─────────────────────────────────────────────────
  static const String serverListName = 'serverList';
  static const String serverListPath = '/';

  // ── Server form (children of /) ────────────────────────────────────────
  static const String serverAddName = 'serverAdd';
  static const String serverAddPath = 'servers/add';

  static const String serverEditName = 'serverEdit';
  static const String serverEditPath = 'servers/:id/edit';

  // ── Workspace shell tab routes (absolute, under ShellRoute) ───────────
  static const String toolsTabPath = '/servers/:id/tools';
  static const String toolDetailPath = '/servers/:id/tools/:name';

  static const String resourcesTabPath = '/servers/:id/resources';
  static const String resourceDetailPath = '/servers/:id/resources/detail';

  static const String promptsTabPath = '/servers/:id/prompts';
  static const String promptDetailPath = '/servers/:id/prompts/:name';

  static const String logTabPath = '/servers/:id/log';

  // ── Helpers ────────────────────────────────────────────────────────────

  /// `/servers/<id>/tools`
  static String toolsList(String id) => '/servers/$id/tools';

  /// `/servers/<id>/tools/<encodedName>`
  static String toolDetail(String id, String name) =>
      '/servers/$id/tools/${Uri.encodeComponent(name)}';

  /// `/servers/<id>/resources`
  static String resourcesList(String id) => '/servers/$id/resources';

  /// `/servers/<id>/resources/detail`  (pass uri via `extra`)
  static String resourceDetail(String id) => '/servers/$id/resources/detail';

  /// `/servers/<id>/prompts`
  static String promptsList(String id) => '/servers/$id/prompts';

  /// `/servers/<id>/prompts/<encodedName>`
  static String promptDetail(String id, String name) =>
      '/servers/$id/prompts/${Uri.encodeComponent(name)}';

  /// `/servers/<id>/log`
  static String logTab(String id) => '/servers/$id/log';

  /// `/servers/<id>` – redirects to tools tab
  static String serverWorkspace(String id) => '/servers/$id';
}
