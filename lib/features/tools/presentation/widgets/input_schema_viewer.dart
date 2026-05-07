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
    final requiredFields = fields.where((f) => f.isRequired).toList();
    final optionalFields = fields.where((f) => !f.isRequired).toList();

    return Column(
      children: [
        _FieldsWrap(fields: requiredFields, title: 'Required Fields'),
        const SizedBox(height: 8),
        _FieldsWrap(fields: optionalFields, title: 'Optional Fields'),
      ],
    );
  }
}

class _InputFieldWidget extends StatelessWidget {
  final FieldModel field;
  const _InputFieldWidget({required this.field});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            field.name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(field.type, style: TextStyle(fontSize: 12)),
          if (field.defaultValue != null)
            Text(
              'Default: ${jsonEncode(field.defaultValue)}',
              style: TextStyle(fontSize: 12),
            ),
        ],
      ),
    );
  }
}

class _FieldsWrap extends StatelessWidget {
  final List<FieldModel> fields;
  final String title;
  const _FieldsWrap({required this.fields, required this.title});

  @override
  Widget build(BuildContext context) {
    return fields.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: fields
                      .map((field) => _InputFieldWidget(field: field))
                      .toList(),
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
