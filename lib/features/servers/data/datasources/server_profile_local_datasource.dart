import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:mcp_visualizer/features/servers/domain/models/server_profile.dart';

const _kProfilesKey = 'mcp_server_profiles';

class ServerProfileLocalDatasource {
  ServerProfileLocalDatasource(this._prefs);

  final SharedPreferences _prefs;

  List<ServerProfile> readAll() {
    final raw = _prefs.getString(_kProfilesKey);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .cast<Map<String, dynamic>>()
        .map(ServerProfile.fromJson)
        .toList();
  }

  Future<void> writeAll(List<ServerProfile> profiles) async {
    final encoded = jsonEncode(profiles.map((p) => p.toJson()).toList());
    await _prefs.setString(_kProfilesKey, encoded);
  }
}
