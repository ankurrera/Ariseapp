import 'package:flutter/material.dart';
import '../../config/theme.dart';
import 'corner_decoration.dart';

class SystemPanel extends StatelessWidget {
  final Widget child;
  final String? title;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final bool showCorners;
  final bool showGlow;

  const SystemPanel({
    super.key,
    required this.child,
    this.title,
    this.padding,
    this.width,
    this.height,
    this.showCorners = true,
    this.showGlow = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget panel = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: SoloLevelingTheme.darkPanel,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: SoloLevelingTheme.darkPanelBorder,
          width: 1,
        ),
        boxShadow: showGlow
            ? [
                BoxShadow(
                  color: SoloLevelingTheme.glowBlue.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Stack(
        children: [
          Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: SoloLevelingTheme.glowText(20),
                  ),
                  const SizedBox(height: 16),
                ],
                Flexible(child: child),
              ],
            ),
          ),
          if (showCorners) ...[
            const Positioned(
              top: 0,
              left: 0,
              child: CornerDecoration(corner: Corner.topLeft),
            ),
            const Positioned(
              top: 0,
              right: 0,
              child: CornerDecoration(corner: Corner.topRight),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              child: CornerDecoration(corner: Corner.bottomLeft),
            ),
            const Positioned(
              bottom: 0,
              right: 0,
              child: CornerDecoration(corner: Corner.bottomRight),
            ),
          ],
        ],
      ),
    );

    return panel;
  }
}
