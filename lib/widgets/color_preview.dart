import 'package:flutter/material.dart';
import 'package:not_apple_solutions/other/enums.dart';

class ColorPreview extends StatelessWidget {
  final BindingColor color;
  const ColorPreview(this.color, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Theme.of(context).textTheme.bodyText2?.fontSize,
      width: Theme.of(context).textTheme.bodyText2?.fontSize,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: _getColor(color), border: Border.all(color: Theme.of(context).splashColor)),
    );
  }

  _getColor(BindingColor color) {
    switch (color) {
      case BindingColor.blue:
        return Colors.blue.shade300;
      case BindingColor.pink:
        return Colors.pink.shade300;
      case BindingColor.green:
        return Colors.green.shade300;
      default:
        return Colors.transparent;
    }
  }
}
