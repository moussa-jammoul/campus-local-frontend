import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/form.dart';

class ImageVideosFileSheet extends ConsumerWidget {
  const ImageVideosFileSheet({super.key , required this.courseDetail});

  final Course courseDetail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: scheme.surface.withValues(alpha: 0.15),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border(
              top: BorderSide(
                color: scheme.onSurface.withValues(alpha: 0.12),
                width: 1,
              ),
            ),
          ),
          padding: EdgeInsets.fromLTRB(20, 12, 20, 20 + bottomInset),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag Handle
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: scheme.onSurfaceVariant.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              Text(
                courseDetail.courseName,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: scheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),

              _MediaOptionTile(
                icon: Icons.image_rounded,
                label: 'Images',
                onTap: () {
                  ///TODO : open images page
                },
              ),
              const SizedBox(height: 10),
              _MediaOptionTile(
                icon: Icons.videocam_rounded,
                label: 'Videos',
                onTap: () {

                  ///TODO : open videos page

                },
              ),
              const SizedBox(height: 10),
              _MediaOptionTile(
                icon: Icons.insert_drive_file_rounded,
                label: 'Files',
                onTap: () {
                  ///TODO : open files page
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MediaOptionTile extends StatelessWidget {
  const _MediaOptionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHigh.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: scheme.outlineVariant.withValues(alpha: 0.3),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: scheme.primary, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: scheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}