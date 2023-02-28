import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoundIconButtonWidget extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final EdgeInsetsGeometry? padding;
  final double? size;
  final Color? color;

  const RoundIconButtonWidget({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.padding,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: size! + 4,
      padding: padding,
      constraints: const BoxConstraints(),
      tooltip: tooltip,
      icon: Icon(icon, color: color, size: size),
      /*icon: SvgPicture.asset(
        icon,
        height: height,
        width: width,
        color: color,
      ),*/
    );
  }
}
