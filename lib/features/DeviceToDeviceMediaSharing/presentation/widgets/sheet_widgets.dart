import 'package:flutter/material.dart';


class SheetMessage extends StatelessWidget {
  final String message;
  final IconData icon;
  final VoidCallback? onRetry;

  const SheetMessage({
    super.key,
    required this.message,
    required this.icon,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: scheme.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 12),
              TextButton(onPressed: onRetry, child: const Text('Retry')),
            ],
          ],
        ),
      ),
    );
  }
}

class SheetLoading extends StatelessWidget {
  const SheetLoading({super.key});

  @override
  Widget build(BuildContext context) =>
      const Center(child: CircularProgressIndicator());
}


class SheetItemTile extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const SheetItemTile({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        tileColor: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: scheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: description.trim().isEmpty
            ? null
            : Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: scheme.onSurfaceVariant),
              ),
        trailing: Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
      ),
    );
  }
}