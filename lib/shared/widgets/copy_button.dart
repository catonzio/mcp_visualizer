import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyButton extends StatefulWidget {
  const CopyButton({
    super.key,
    required this.text,
    this.tooltip = 'Copy to clipboard',
    this.iconSize = 20,
  });

  final String text;
  final String tooltip;
  final double iconSize;

  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton> {
  bool _copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.text));
    setState(() => _copied = true);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );

    await Future<void>.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: IconButton(
        icon: Icon(
          _copied ? Icons.check_rounded : Icons.copy_rounded,
          size: widget.iconSize,
        ),
        onPressed: _copy,
      ),
    );
  }
}
