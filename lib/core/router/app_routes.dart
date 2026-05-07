/// Route name and path constants for the app.
abstract final class AppRoutes {
  // ── Server list (home) ─────────────────────────────────────────────────
  static const String serverListName = 'serverList';
  static const String serverListPath = '/';

  // ── Server form ────────────────────────────────────────────────────────
  static const String serverAddName = 'serverAdd';
  static const String serverAddPath = 'servers/add';

  static const String serverEditName = 'serverEdit';
  static const String serverEditPath = 'servers/:id/edit';

  // ── Server workspace ───────────────────────────────────────────────────
  static const String serverWorkspaceName = 'serverWorkspace';
  static const String serverWorkspacePath = 'servers/:id';

  // ── Tool detail ────────────────────────────────────────────────────────
  static const String toolDetailName = 'toolDetail';
  static const String toolDetailPath = 'tools/:name';

  // ── Resource detail ────────────────────────────────────────────────────
  static const String resourceDetailName = 'resourceDetail';
  static const String resourceDetailPath = 'resources/detail';

  // ── Prompt detail ──────────────────────────────────────────────────────
  static const String promptDetailName = 'promptDetail';
  static const String promptDetailPath = 'prompts/:name';

  // ── Helpers ────────────────────────────────────────────────────────────

  /// `/servers/<id>`
  static String serverWorkspace(String id) => '/servers/$id';

  /// `/servers/<id>/tools/<encodedName>`
  static String toolDetail(String id, String name) =>
      '/servers/$id/tools/${Uri.encodeComponent(name)}';

  /// `/servers/<id>/resources/detail`  (pass uri via `extra`)
  static String resourceDetail(String id) => '/servers/$id/resources/detail';

  /// `/servers/<id>/prompts/<encodedName>`
  static String promptDetail(String id, String name) =>
      '/servers/$id/prompts/${Uri.encodeComponent(name)}';
}
