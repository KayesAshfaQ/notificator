import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoundIconButtonWidget extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final EdgeInsetsGeometry? padding;
  final double? size;
  final Color? color;
  final double? angle;

  const RoundIconButtonWidget({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.padding,
    this.size,
    this.color,
    this.angle = 0,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: size! + 4,
      padding: padding,
      constraints: const BoxConstraints(),
      tooltip: tooltip,
      icon: Transform.rotate(
        angle: angle! * (pi / 180), // rotate 45 degrees in radians
        child: Icon(icon, color: color, size: size),
      ),
      /*icon: SvgPicture.asset(
        icon,
        height: height,
        width: width,
        color: color,
      ),*/
    );
  }
}
