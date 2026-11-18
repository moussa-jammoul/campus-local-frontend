import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/courses_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/semester/form.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/widgets/choosing_location_to_save_media_sheet.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/widgets/sheet_widgets.dart';


class SheetCoursesPage extends ConsumerStatefulWidget {
  final Semester semester;

  const SheetCoursesPage({super.key, required this.semester});

  @override
  ConsumerState<SheetCoursesPage> createState() => _SheetCoursesPageState();
}

class _SheetCoursesPageState extends ConsumerState<SheetCoursesPage> {
  
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(_loadCourses);
  }

  Future<void> _loadCourses() async {
    final semesterUuid = widget.semester.uuid;

    if (semesterUuid == null) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      await ref
          .read(courseProvider.notifier)
          .readData(widget.semester.userUid, semesterUuid);
      if (!mounted) return;
      setState(() => _isLoading = false);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  void _onCourseTap(Course course) {
    final semesterUuid = widget.semester.uuid;
    final courseUuid = course.uuid;
    if (semesterUuid == null || courseUuid == null) return;

    final SaveLocation result = (
      semesterUuid: semesterUuid,
      courseUuid: courseUuid,
    );
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final courses = ref.watch(courseProvider);

    if (_isLoading) return const SheetLoading();

    if (_hasError) {
      return SheetMessage(
        icon: Icons.error_outline,
        message: 'Failed to load courses.',
        onRetry: _loadCourses,
      );
    }

    if (courses == null) return const SheetLoading();

    if (courses.isEmpty) {
      return const SheetMessage(
        icon: Icons.folder_off_outlined,
        message: 'No courses available.\nClose this sheet and add one first.',
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          for (final course in courses)
            SheetItemTile(
              title: course.courseName,
              description: course.description,
              onTap: () => _onCourseTap(course),
            ),
        ],
      ),
    );
  }
}