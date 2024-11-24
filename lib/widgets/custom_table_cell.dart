import 'package:flutter/material.dart';

/// Custom table cell widget
class CustomTableCell extends StatelessWidget {
  /// Text to display
  final String text;

  /// Constructor with [text] and optional [key]
  const CustomTableCell(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text),
      ),
    );
  }
}
