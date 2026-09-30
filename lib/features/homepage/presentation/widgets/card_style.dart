import 'package:flutter/material.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/page/settings_page.dart';

class CardStyleWidget extends StatelessWidget {
   const CardStyleWidget({
    super.key,
    required this.child,
    this.constraints,
    this.kwidth,
    this.margin = const EdgeInsetsGeometry.all(10),
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  });

  final Widget child;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry padding;
  final double? kwidth;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: kwidth ?? kSettingsWidth,
      constraints: constraints,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.4), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: child,
    );
  }
}