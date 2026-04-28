import 'dart:convert';

import 'package:flutter/material.dart';

/// A validated JSON text area widget.
///
/// Parses the user's input on every change and reports either the parsed
/// [Map<String, dynamic>] (via [onChanged]) or a validation error message.
class JsonInputField extends StatefulWidget {
  const JsonInputField({
    super.key,
    this.initialValue,
    this.onChanged,
    this.label = 'Arguments (JSON)',
    this.hint = '{ "key": "value" }',
    this.minLines = 5,
    this.maxLines = 20,
    this.readOnly = false,
  });

  final String? initialValue;
  final void Function(Map<String, dynamic>? parsed)? onChanged;
  final String label;
  final String hint;
  final int minLines;
  final int maxLines;
  final bool readOnly;

  @override
  State<JsonInputField> createState() => _JsonInputFieldState();
}

class _JsonInputFieldState extends State<JsonInputField> {
  late final TextEditingController _controller;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged(String value) {
    if (value.trim().isEmpty) {
      setState(() => _errorText = null);
      widget.onChanged?.call(null);
      return;
    }

    try {
      final decoded = jsonDecode(value);
      if (decoded is Map<String, dynamic>) {
        setState(() => _errorText = null);
        widget.onChanged?.call(decoded);
      } else {
        setState(() => _errorText = 'Root value must be a JSON object { }');
        widget.onChanged?.call(null);
      }
    } on FormatException catch (e) {
      setState(() => _errorText = e.message);
      widget.onChanged?.call(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: _controller,
      readOnly: widget.readOnly,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 13,
        color: theme.colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        alignLabelWithHint: true,
        errorText: _errorText,
        errorMaxLines: 3,
      ),
      onChanged: _onTextChanged,
    );
  }
}
