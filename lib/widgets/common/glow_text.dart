import 'package:flutter/material.dart';
import '../../config/theme.dart';

class GlowText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;

  const GlowText({
    super.key,
    required this.text,
    this.fontSize = 24,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: SoloLevelingTheme.glowText(fontSize, fontWeight: fontWeight).copyWith(
        color: color,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }
}
