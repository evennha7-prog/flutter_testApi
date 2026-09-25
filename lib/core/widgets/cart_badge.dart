import 'package:flutter/material.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({
    super.key,
    required this.count,
    this.size = 18,
    this.fontSize = 9,
    this.iconSize = 22,
  });

  final int count;
  final double size;
  final double fontSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();

    return Positioned(
      top: 4,
      right: 4,
      child: Container(
        padding: EdgeInsets.all(size * 0.22),
        decoration: const BoxDecoration(
          color: Colors.redAccent,
          shape: BoxShape.circle,
        ),
        constraints: BoxConstraints(
          minWidth: size,
          minHeight: size,
        ),
        child: Text(
          count > 99 ? '99+' : '$count',
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class CartIconButton extends StatelessWidget {
  const CartIconButton({
    super.key,
    required this.count,
    required this.onPressed,
    this.iconColor = Colors.white,
    this.backgroundColor,
    this.iconSize = 22,
    this.showBadge = true,
  });

  final int count;
  final VoidCallback onPressed;
  final Color iconColor;
  final Color? backgroundColor;
  final double iconSize;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? Colors.white.withValues(alpha: 0.15),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.shopping_bag_outlined, size: iconSize, color: iconColor),
            onPressed: onPressed,
          ),
          if (showBadge && count > 0)
            CartBadge(count: count, size: 16, fontSize: 8, iconSize: iconSize),
        ],
      ),
    );
  }
}