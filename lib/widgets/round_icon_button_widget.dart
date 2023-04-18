
import 'package:flutter/material.dart';

class RoundIconButtonWidget extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final EdgeInsetsGeometry? padding;
  final double? size;
  final Color? color;
  final bool? isCustomSize;

  const RoundIconButtonWidget({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.padding,
    this.size,
    this.color,
    this.isCustomSize = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: size! + 4,
      padding: padding,
      constraints: const BoxConstraints(),
      tooltip: tooltip,
      icon: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: isCustomSize! ? size! - 8: size,
        ),
      ),
    );
  }
}
