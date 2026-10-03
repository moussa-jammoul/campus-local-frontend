import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/CoursesPage/service/courses_page_services.dart';

class CourseAppBarGlacier extends ConsumerWidget {
  final String semesterName;
  const CourseAppBarGlacier({super.key, required this.semesterName});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    return SliverAppBar(
      pinned: true,
      expandedHeight: 80,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 80,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: scheme.surface.withValues(alpha: 0.25),
              border: Border(
                bottom: BorderSide(
                  color: scheme.onSurface.withValues(alpha: 0.08),
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                      onPressed: () {
                        Navigator.of(context).pop();
                        ref.read(coursePageServiceProvider.notifier).nullCurrentCourses();
                        
                        },
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        semesterName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: scheme.onSurface,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}