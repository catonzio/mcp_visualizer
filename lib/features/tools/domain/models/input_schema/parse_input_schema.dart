import 'package:mcp_visualizer/features/tools/domain/models/input_schema/field_model.dart';

List<String> extractTypes(Map<String, dynamic> typeDict) {
  String? type = typeDict['type'] as String?;
  final result = <String>{};
  if (type != null) {
    if (type == 'array') {
      final items = typeDict['items'];
      if (items.isNotEmpty) {
        final itemType = items != null
            ? extractTypes(items).join(' | ')
            : 'any';
        type = 'array[$itemType]';
      }
    }
    result.add(type);
  }

  final anyOf = typeDict['anyOf'] as List?;
  if (anyOf != null) {
    final types = anyOf
        .map((option) {
          return extractTypes(option as Map<String, dynamic>);
        })
        .expand((x) => x)
        .toSet();
    result.addAll(types);
  }
  return result.toList();
}

List<FieldModel> parseInputSchema(Map<String, dynamic> schema) {
  final requiredFields =
      (schema['required'] as List?)?.cast<String>() ?? <String>[];
  final properties = schema['properties'] as Map<String, dynamic>;

  final fields = properties.entries.map((entry) {
    final name = entry.key;
    final schema = entry.value as Map<String, dynamic>;
    final isRequired = requiredFields.contains(name);

    final types = extractTypes(schema);
    final type = types.join(' | ');

    return FieldModel(
      name: name,
      type: type,
      isRequired: isRequired,
      defaultValue: schema['default'],
    );
  }).toList();

  return fields;
}

dynamic valueForField(FieldModel model) {
  if (model.defaultValue != null) {
    if (model.defaultValue is String) {
      return model.defaultValue;
    }
    return model.defaultValue.toString();
  }
  if (model.isRequired) {
    return 'Required (${model.type})';
  }
  if (model.type.contains('array')) {
    return [];
  }
  if (model.type.contains('string')) {
    return '';
  }
  if (model.type.contains('number')) {
    return 0;
  }
  if (model.type.contains('boolean')) {
    return false;
  }
  return null;
}

String replaceQuotesAroundRequired(String input) {
  final result = input.replaceAllMapped(
    RegExp(r'"Required \(([^)]+)\)"'),
    (match) => 'Required (${match.group(1)})',
  );
  return result;
}
