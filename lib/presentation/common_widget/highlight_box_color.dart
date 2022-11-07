import 'package:flutter/material.dart';

import '../../theme/theme_color.dart';

class BoxColor extends StatelessWidget {
  final Color color;
  final BorderRadius borderRadius;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxBorder? border;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;

  const BoxColor({
    Key? key,
    required this.color,
    required this.borderRadius,
    this.child,
    this.padding = const EdgeInsets.fromLTRB(6, 4, 6, 4),
    this.margin,
    this.border,
    this.constraints,
    this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      constraints: constraints,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        border: border,
      ),
      child: child,
    );
  }
}

class HighlightBoxColor extends StatelessWidget {
  final Widget? child;
  final Color bgColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry padding;
  final Color? borderColor;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;
  final void Function()? onTap;
  final BorderRadius borderRadius;

  const HighlightBoxColor({
    Key? key,
    this.child,
    this.margin,
    this.padding = const EdgeInsets.all(8),
    this.bgColor = Colors.white,
    this.borderColor,
    this.constraints,
    this.alignment,
    this.onTap,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: BoxColor(
        padding: padding,
        color: bgColor,
        constraints: constraints,
        alignment: alignment,
        border: Border.all(
          color: borderColor ?? themeColor.primaryColor,
          width: 1,
        ),
        borderRadius: borderRadius,
        margin: margin,
        child: child,
      ),
    );
  }
}
