import 'package:fpdart/fpdart.dart';
import 'package:mcp_client/mcp_client.dart';

import 'package:mcp_visualizer/core/errors/mcp_failure.dart';
import 'package:mcp_visualizer/features/servers/domain/models/server_profile.dart';

abstract interface class McpConnectionRepository {
  TaskEither<McpFailure, Client> connect(
    ServerProfile profile, {
    String? authToken,
  });
  TaskEither<McpFailure, Unit> disconnect(Client client);
}
