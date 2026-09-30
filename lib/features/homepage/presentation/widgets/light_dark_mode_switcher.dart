import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/widgets/card_style.dart';
import 'package:flutterfrontenduniprojectmanager/theme/theme_data.dart';
class AppearanceTile extends ConsumerWidget {
  const AppearanceTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    // ignore: unused_local_variable
    final themeMode = ref.watch(themeModeProvider);//used just to make the widget rebuild when user toggle the button
    final isDark = Theme.of(context).brightness == Brightness.dark; 

    return CardStyleWidget(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(
            isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
            color: scheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Dark mode',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface,
                  ),
            ),
          ),
          Switch(
            value: isDark,
            activeThumbColor: scheme.primary,
            activeTrackColor: scheme.primaryContainer,
            inactiveThumbColor: scheme.outline,
            inactiveTrackColor: scheme.surfaceContainerHighest,
            thumbIcon: WidgetStateProperty.resolveWith((states) {
              return Icon(
                states.contains(WidgetState.selected)
                    ? Icons.dark_mode_rounded
                    : Icons.light_mode_rounded,
                color: states.contains(WidgetState.selected)
                    ? scheme.onPrimary
                    : scheme.onSurfaceVariant,
                size: 16,
              );
            }),
            onChanged: (value) {
               ref.read(themeModeProvider.notifier).setThemeMode(
                    value ? ThemeMode.dark : ThemeMode.light,
                  );
            },
          ),
        ],
      ),
    );
  }
}