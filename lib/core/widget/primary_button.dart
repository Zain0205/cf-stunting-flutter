import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String textButton;
  final VoidCallback? onTap;
  final bool btnReverse;
  final double borderRadius;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  const PrimaryButton({
    super.key,
    required this.textButton,
    this.onTap,
    this.btnReverse = false,
    this.borderRadius = 30,
    this.fontSize = 16,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1E63E5);
    final backgroundColor = btnReverse ? Colors.white : primaryColor;
    final textColor = btnReverse ? primaryColor : Colors.white;
    final splashColor = btnReverse
        ? primaryColor.withValues(alpha: .1)
        : Colors.white.withValues(alpha: .3);
    final highlightColor = btnReverse
        ? primaryColor.withValues(alpha: .05)
        : Colors.white.withValues(alpha: .1);

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        splashColor: splashColor,
        highlightColor: highlightColor,
        child: Container(
          width: double.infinity,
          padding: padding,
          decoration: btnReverse
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(color: primaryColor, width: 1.0),
                )
              : null,
          child: Center(
            child: Text(
              textButton,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
