import 'package:flutter/material.dart';

import 'app_colors.dart';

class GlowContainer extends StatelessWidget {
  const GlowContainer({required this.child, super.key, this.glowColor});

  final Widget child;
  final Color? glowColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: (glowColor ?? AppColors.accentPrimary).withOpacity(0.25),
            blurRadius: 18,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}
