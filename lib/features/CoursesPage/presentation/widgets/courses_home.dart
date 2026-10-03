import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/courses_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/semester/form.dart';
import 'package:flutterfrontenduniprojectmanager/features/CoursesPage/presentation/widgets/image_videos_file_sheet.dart';
import 'package:flutterfrontenduniprojectmanager/features/CoursesPage/service/courses_page_services.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/widgets/card_style.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/widgets/semesters_home.dart';

class CoursesHome extends ConsumerStatefulWidget {
  final Semester semester;
  const CoursesHome({super.key, required this.semester});

  @override
  ConsumerState<CoursesHome> createState() => _CoursesHomeState();
}

class _CoursesHomeState extends ConsumerState<CoursesHome> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _professorController;
  bool _creatingCourse = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _professorController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _professorController.dispose();
    super.dispose();
  }

  Future<void> createNewCourse(String courseName, String description, String professorName) async {
    if (FirebaseAuth.instance.currentUser != null) {
      await ref.read(coursePageServiceProvider.notifier).createNewCourse(
            Course(
              userUid: FirebaseAuth.instance.currentUser!.uid,
              semesterUuid: widget.semester.uuid!,
              courseName: courseName,
              description: description,
              professorName: professorName.isEmpty ? 'doctor' : professorName,
            ),
          );
    }
  }

  Future<void> showCreateCourseBottomSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (context) {
        final scheme = Theme.of(context).colorScheme;
        final textTheme = Theme.of(context).textTheme;
        final bottomInset = MediaQuery.of(context).viewInsets.bottom;

        return StatefulBuilder(
          builder: (context, setModalState) {
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          'Create New Course',
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: scheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _nameController,
                          enabled: !_creatingCourse,
                          textCapitalization: TextCapitalization.words,
                          style: textTheme.bodyMedium?.copyWith(color: scheme.onSurface),
                          decoration: InputDecoration(
                            labelText: 'Course Name',
                            hintText: 'e.g. Data Structures',
                            prefixIcon: const Icon(Icons.menu_book_rounded, size: 20),
                            filled: true,
                            fillColor: scheme.surfaceContainerHigh.withValues(alpha: 0.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: scheme.outlineVariant.withValues(alpha: 0.3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: scheme.primary, width: 1.5),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a course name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _professorController,
                          enabled: !_creatingCourse,
                          textCapitalization: TextCapitalization.words,
                          style: textTheme.bodyMedium?.copyWith(color: scheme.onSurface),
                          decoration: InputDecoration(
                            labelText: 'Professor Name',
                            hintText: 'Your doctor Name! (optional)',
                            prefixIcon: const Icon(Icons.person_rounded, size: 20),
                            filled: true,
                            fillColor: scheme.surfaceContainerHigh.withValues(alpha: 0.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: scheme.outlineVariant.withValues(alpha: 0.3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: scheme.primary, width: 1.5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _descriptionController,
                          enabled: !_creatingCourse,
                          maxLines: 3,
                          minLines: 1,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a description';
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.sentences,
                          style: textTheme.bodyMedium?.copyWith(color: scheme.onSurface),
                          decoration: InputDecoration(
                            labelText: 'Description',
                            hintText: 'e.g. Core subject',
                            prefixIcon: const Icon(Icons.description_rounded, size: 20),
                            filled: true,
                            fillColor: scheme.surfaceContainerHigh.withValues(alpha: 0.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: scheme.outlineVariant.withValues(alpha: 0.3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: scheme.primary, width: 1.5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: _creatingCourse
                                ? null
                                : () async {
                                    if (_formKey.currentState?.validate() ?? false) {
                                      final name = _nameController.text.trim();
                                      final description = _descriptionController.text.trim();
                                      final professor = _professorController.text.trim();

                                      setModalState(() => _creatingCourse = true);
                                      try {
                                        await createNewCourse(name, description, professor);
                                      } finally {
                                        setModalState(() => _creatingCourse = false);
                                        if(context.mounted){
                                        Navigator.of(context).pop();
                                        }
                                      }
                                    }
                                  },
                            child: _creatingCourse
                                ? SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: scheme.onPrimary,
                                    ),
                                  )
                                : Text(
                                    'Create Course',
                                    style: textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: scheme.onPrimary,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final courses = ref.watch(courseProvider);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.menu_book_rounded, size: 22, color: scheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Courses',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurface,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    showCreateCourseBottomSheet(context);
                  },
                  icon: const Icon(Icons.add),
                ),
                if (courses != null && courses.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${courses.length} Total',
                      style: textTheme.labelSmall?.copyWith(
                        color: scheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
        if (courses == null)
          const ContainerCard(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: CircularProgressIndicator(strokeWidth: 2.5)),
            ),
          )
        else if (courses.isEmpty)
          ContainerCard(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.folder_open_rounded,
                      size: 48,
                      color: scheme.outline,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'No courses found',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'You do not have any courses registered for this semester.',
                      textAlign: TextAlign.center,
                      style: textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: courses.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (_, i) => _CourseTile(course: courses[i]),
          ),
      ],
    );
  }
}


class _CourseTile extends ConsumerWidget {


  void showImageVideoFileSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.3),
    builder: (context) =>  ImageVideosFileSheet(courseDetail: course,),
  );
}

  Future<void> showEditingCourseDialog({
    required WidgetRef ref,
    required BuildContext context,
    required Course course,
  }) async {
    final updatedData = await showDialog<Course?>(
      context: context,
      useSafeArea: false,
      barrierColor: Colors.transparent,
      builder: (context) {
        return _EditingCourseDialogContent(
          initialName: course.courseName,
          initialDescription: course.description,
          initialProfessor: course.professorName,
          course: course,
        );
      },
    );
    if (updatedData != null) {
      await ref.read(coursePageServiceProvider.notifier).updateCourse(updatedData);
    }
  }

  const _CourseTile({required this.course});

  final Course course;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ContainerCard(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            showImageVideoFileSheet(context);
          },
          onLongPress: () {
            unawaited(showEditingCourseDialog(
              ref: ref,
              context: context,
              course: course,
            ));
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.menu_book_rounded,
                    color: scheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.courseName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: scheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(Icons.person_rounded, size: 12, color: scheme.onSurfaceVariant),
                          const SizedBox(width: 4),
                          Text(
                            course.professorName,
                            style: textTheme.labelSmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      if (course.description.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          course.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 12,
                            color: scheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatDate(course.createdAt),
                            style: textTheme.labelSmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: scheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _formatDate(DateTime? date) {
  if (date == null) return 'Unknown date';
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  final d = date.toLocal();
  return '${months[d.month - 1]} ${d.day}, ${d.year}';
}

///those widgets under here are used for editing a course

class _EditingCourseDialogContent extends StatefulWidget {
  const _EditingCourseDialogContent({
    required this.course,
    required this.initialName,
    required this.initialDescription,
    required this.initialProfessor,
  });

  final String initialName;
  final String initialDescription;
  final String initialProfessor;
  final Course course;

  @override
  State<_EditingCourseDialogContent> createState() => __EditingCourseDialogContentState();
}

class __EditingCourseDialogContentState extends State<_EditingCourseDialogContent> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _professorController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _descriptionController = TextEditingController(text: widget.initialDescription);
    _professorController = TextEditingController(text: widget.initialProfessor);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _professorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          width: size.width,
          height: size.height,
          color: Colors.black.withValues(alpha: 0.35),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CardStyleWidget(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.edit_rounded, size: 18, color: scheme.primary),
                          const SizedBox(width: 8),
                          Text(
                            'Course Name',
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: scheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _nameController,
                        style: textTheme.bodyMedium,
                        decoration: InputDecoration(
                          hintText: 'e.g. Data Structures',
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          filled: true,
                          fillColor: scheme.surfaceContainerLow.withValues(alpha: 0.6),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                CardStyleWidget(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person_rounded, size: 18, color: scheme.primary),
                          const SizedBox(width: 8),
                          Text(
                            'Professor Name',
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: scheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _professorController,
                        style: textTheme.bodyMedium,
                        decoration: InputDecoration(
                          hintText: 'e.g. Dr. Smith',
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          filled: true,
                          fillColor: scheme.surfaceContainerLow.withValues(alpha: 0.6),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                CardStyleWidget(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.description_rounded, size: 18, color: scheme.primary),
                          const SizedBox(width: 8),
                          Text(
                            'Description',
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: scheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _descriptionController,
                        maxLines: 3,
                        minLines: 2,
                        style: textTheme.bodyMedium,
                        decoration: InputDecoration(
                          hintText: 'Details...',
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          filled: true,
                          fillColor: scheme.surfaceContainerLow.withValues(alpha: 0.6),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                CardStyleWidget(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 44,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop(null);
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: scheme.outline.withValues(alpha: 0.4),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Exit'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 44,
                          child: FilledButton(
                            onPressed: () {
                              final newData = Course(
                                userUid: widget.course.userUid,
                                semesterUuid: widget.course.semesterUuid,
                                courseName: _nameController.text.trim(),
                                description: _descriptionController.text.trim(),
                                professorName: _professorController.text.trim().isEmpty
                                    ? 'doctor'
                                    : _professorController.text.trim(),
                                id: widget.course.id,
                                uuid: widget.course.uuid,
                                ///no need for other details
                              );
                              Navigator.of(context).pop(newData);
                            },
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Save'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}