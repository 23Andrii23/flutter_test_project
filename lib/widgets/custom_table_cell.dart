import 'package:flutter/material.dart';

/// Custom table cell widget
class CustomTableCell extends StatelessWidget {
  /// Text to display
  final String text;

  /// Flag to check if the text is bigger than another
  final bool? isBiggerThenAnother;

  /// Constructor with [text] and optional [key]
  const CustomTableCell(
    this.text, {
    this.isBiggerThenAnother,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text, style: TextStyle(color: _textColor())),
      ),
    );
  }

  Color _textColor() {
    return switch (isBiggerThenAnother) {
      true => Colors.green,
      false => Colors.red,
      null => Colors.black,
    };
  }
}
