import 'package:flutter/material.dart';
import 'package:omnisense/src/configs/configs.dart';
import 'package:omnisense/src/extensions/build_context.dart';
import 'package:omnisense/src/extensions/num.dart';

class OmnisenseButton extends StatelessWidget {
  const OmnisenseButton({
    required this.text,
    this.action,
    this.color = Palette.primary,
    super.key,
    this.width = .9,
    this.icon,
    this.textColor,
  });
  final Widget? icon;
  final String text;
  final VoidCallback? action;
  final Color color;
  final Color? textColor;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: context.width * width,
        height: Constants.buttonHeight,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(Constants.borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              8.hGap,
            ] else
              const SizedBox.shrink(),
            Text(
              text,
              style: context.bodyLg.copyWith(
                color: textColor ?? context.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OmnisenseButtonMedium extends StatelessWidget {
  const OmnisenseButtonMedium({
    required this.text,
    this.action,
    this.color = Palette.primary,
    super.key,
    this.width = .35,
    this.icon,
  });
  final Widget? icon;
  final String text;
  final VoidCallback? action;
  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return OmnisenseButton(
      text: text,
      action: action,
      color: color,
      width: width,
      icon: icon,
    );
  }
}
