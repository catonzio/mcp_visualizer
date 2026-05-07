import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:mcp_visualizer/features/tools/domain/models/input_schema/field_model.dart';

class InputSchemaViewer extends StatelessWidget {
  final Map<String, dynamic> schema;
  const InputSchemaViewer({super.key, required this.schema});

  @override
  Widget build(BuildContext context) {
    final fields = parseInputSchema(schema);

    return Column(
      children: fields.map((field) => _InputFieldWidget(field: field)).toList(),
    );
  }
}

class _InputFieldWidget extends StatelessWidget {
  final FieldModel field;
  const _InputFieldWidget({required this.field});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(field.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${field.type}'),
            if (field.defaultValue != null)
              Text('Default: ${jsonEncode(field.defaultValue)}'),
            if (field.isRequired) const Text('Required'),
          ],
        ),
      ),
    );
  }
}

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
