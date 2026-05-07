import 'package:freezed_annotation/freezed_annotation.dart';

part 'tool_model.freezed.dart';

@freezed
abstract class ToolModel with _$ToolModel {
  const factory ToolModel({
    required String name,
    required String description,
    required Map<String, dynamic> inputSchema,
  }) = _ToolModel;
}
