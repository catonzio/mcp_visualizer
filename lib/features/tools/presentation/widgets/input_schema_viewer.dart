import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:mcp_visualizer/features/tools/domain/models/input_schema/field_model.dart';
import 'package:mcp_visualizer/features/tools/domain/models/input_schema/parse_input_schema.dart';

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
