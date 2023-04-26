import 'package:flutter/material.dart';

class OmnisenseBoxedIcon extends StatelessWidget {
  const OmnisenseBoxedIcon({
    super.key,
    this.action,
    required this.color,
    required this.icon,
  });

  final VoidCallback? action;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          height: 52,
          width: 52,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Icon(
              icon,
            ),
          ),
        ),
      ),
    );
  }
}
