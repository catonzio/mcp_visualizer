import 'package:freezed_annotation/freezed_annotation.dart';

part 'resource_model.freezed.dart';

@freezed
abstract class ResourceModel with _$ResourceModel {
  const factory ResourceModel({
    required String uri,
    required String name,
    required String description,
    String? mimeType,
  }) = _ResourceModel;
}
