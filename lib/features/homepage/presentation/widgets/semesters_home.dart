// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:ui';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/semester/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/semester/semester_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/widgets/card_style.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/service/home_page_services.dart';

class SemestersHome extends ConsumerStatefulWidget {
  const SemestersHome({super.key});

  @override
  ConsumerState<SemestersHome> createState() => _SemestersHomeState();
}

class _SemestersHomeState extends ConsumerState<SemestersHome> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  bool _creatingSemester = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> createNewSemester(String semesterName, String semesterDescription) async {
  if (FirebaseAuth.instance.currentUser != null) {
    await ref.read(homePageServiceProvider.notifier).createNewSemester(
          Semester(
            userUid: FirebaseAuth.instance.currentUser!.uid,
            semesterName: semesterName,
            description: semesterDescription,
            finishedOrYet: false,
          ),
        );
  }
}

Future<void> showCreateSemesterBottomSheet(BuildContext context) async {
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

                      // Header Title
                      Text(
                        'Create New Semester',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: scheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _nameController,
                        enabled: !_creatingSemester,
                        textCapitalization: TextCapitalization.words,
                        style: textTheme.bodyMedium?.copyWith(color: scheme.onSurface),
                        decoration: InputDecoration(
                          labelText: 'Semester Name',
                          hintText: 'e.g. Semester 1',
                          prefixIcon: const Icon(Icons.school_rounded, size: 20),
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
                            return 'Please enter a semester name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),

                      TextFormField(
                        controller: _descriptionController,
                        enabled: !_creatingSemester,
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
                          hintText: 'e.g. Core subjects',
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
                          onPressed: _creatingSemester
                              ? null
                              : () async {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    final name = _nameController.text.trim();
                                    final description = _descriptionController.text.trim();

                                    setModalState(() => _creatingSemester = true);
                                    try {
                                     await createNewSemester(name, description);
                                    } finally {
                                      setModalState(() => _creatingSemester = false);
                                    } 
                                  }
                                },
                          child: _creatingSemester
                              ? SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: scheme.onPrimary,
                                  ),
                                )
                              : Text(
                                  'Create Semester',
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
    final semesters = ref.watch(semesterProvider);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.school_rounded, size: 22, color: scheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Semesters',
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
                    showCreateSemesterBottomSheet(context);
                  },
                  icon: const Icon(Icons.add),
                ),
                if (semesters != null && semesters.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${semesters.length} Total',
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

        if (semesters == null)
          const ContainerCard(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: CircularProgressIndicator(strokeWidth: 2.5)),
            ),
          )
        else if (semesters.isEmpty)
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
                      'No semesters found',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'You do not have any active or past semesters registered.',
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
              itemCount: semesters.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _SemesterTile(semester: semesters[i]),
            ),
          
      ],
    );
  }
}

class ContainerCard extends StatelessWidget {
  const ContainerCard({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: child,
    );
  }
}

class _SemesterTile extends ConsumerWidget {



  Future<void> showEditingSemesterDialog({
    required WidgetRef ref,
  required BuildContext context,
  required Semester sem,
}) async {
  final updatedData = await showDialog<Semester?>(
    context: context,
    useSafeArea: false, 
    barrierColor: Colors.transparent, 
    builder: (context) {
      return _EditingSemesterDialogContent(
        initialName: sem.semesterName,
        initialDescription: sem.description,
        initialIsDone: sem.finishedOrYet,
        sem: sem,
      );
    },
  );
  if(updatedData != null){
  await ref.read(homePageServiceProvider.notifier).updateSemester(updatedData);
  }
  
  
  

}
  const _SemesterTile({required this.semester});

  final Semester semester;

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final isFinished = semester.finishedOrYet;
    final statusColor = isFinished ? Colors.green : scheme.primary;

    return ContainerCard(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // TODO: Open semester details page
          },
          onLongPress: () {
            unawaited(showEditingSemesterDialog(
              ref: ref,
              context: context , 
              sem: semester
              ));
            
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon indicator box
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    isFinished ? Icons.task_alt_rounded : Icons.timelapse_rounded,
                    color: statusColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),

                // Main Info Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              semester.semesterName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: scheme.onSurface,
                              ),
                            ),
                          ),
                          _StatusBadge(
                            finished: isFinished,
                            color: statusColor,
                          ),
                        ],
                      ),
                      if (semester.description.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          semester.description,
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
                            _formatDate(semester.createdAt),
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

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.finished, required this.color});

  final bool finished;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        finished ? 'Completed' : 'Ongoing',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
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






///those widgets under here are used for editing a semester

class _EditingSemesterDialogContent extends StatefulWidget {
  const _EditingSemesterDialogContent({
    required this.sem,
    required this.initialName,// we prefered to pass those excplicity instead of using the semester because they are describing what they should be used for (e.g initial value which was already the semester information)
    required this.initialDescription,
    required this.initialIsDone,
  });

  final String initialName;
  final String initialDescription;
  final bool initialIsDone;
  final Semester sem;

  @override
  State<_EditingSemesterDialogContent> createState() =>
      __EditingSemesterDialogContentState();
}

class __EditingSemesterDialogContentState
    extends State<_EditingSemesterDialogContent> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late bool _isDone;

  @override
  void initState() {
    super.initState();
    // Default values assigned here
    _nameController = TextEditingController(text: widget.initialName);
    _descriptionController =
        TextEditingController(text: widget.initialDescription);
    _isDone = widget.initialIsDone;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
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
                          Icon(Icons.edit_rounded,
                              size: 18, color: scheme.primary),
                          const SizedBox(width: 8),
                          Text(
                            'Semester Name',
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
                          hintText: 'e.g. Semester 1',
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          filled: true,
                          fillColor:
                              scheme.surfaceContainerLow.withValues(alpha: 0.6),
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
                          Icon(Icons.description_rounded,
                              size: 18, color: scheme.primary),
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
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          filled: true,
                          fillColor:
                              scheme.surfaceContainerLow.withValues(alpha: 0.6),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Status',
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: scheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _isDone ? 'Completed' : 'In Progress',
                            style: textTheme.bodySmall?.copyWith(
                              color: _isDone
                                  ? scheme.primary
                                  : scheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: _isDone,
                        onChanged: (value) {
                          setState(() {
                            _isDone = value;
                          });
                        },
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

                      // Save Button
                      Expanded(
                        child: SizedBox(
                          height: 44,
                          child: FilledButton(
                            onPressed: () {
                              final newData = Semester(
                                userUid: widget.sem.userUid, 
                                semesterName: _nameController.text.trim(), 
                                description: _descriptionController.text.trim(), 
                                finishedOrYet: _isDone,
                                id: widget.sem.id //required to compare logique inside the db service
                                ///no need to implement other details because the db only update those three values
                                ///Updated at handled automatically inside the local data base to update the value of it
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