import 'package:fpdart/fpdart.dart';

import 'package:mcp_visualizer/core/errors/mcp_failure.dart';
import 'package:mcp_visualizer/features/servers/domain/models/server_profile.dart';

abstract interface class ServerProfileRepository {
  TaskEither<McpFailure, List<ServerProfile>> getAll();
  TaskEither<McpFailure, ServerProfile> getById(String id);
  TaskEither<McpFailure, Unit> save(ServerProfile profile);
  TaskEither<McpFailure, Unit> delete(String id);
}
