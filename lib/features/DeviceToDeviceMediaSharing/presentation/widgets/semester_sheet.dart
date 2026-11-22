import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/semester/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/semester/semester_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/widgets/sheet_widgets.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.

class SheetSemestersPage extends ConsumerWidget {
  final ValueChanged<Semester> onSemesterSelected;

  const SheetSemestersPage({super.key, required this.onSemesterSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final semesters = ref.watch(semesterProvider);

    if (semesters == null) return const SheetLoading();

    if (semesters.isEmpty) {
      return const SheetMessage(
        icon: Icons.folder_off_outlined,
        message: 'No semesters available.\nClose this sheet and add one first.',
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          for (final semester in semesters)
            SheetItemTile(
              title: semester.semesterName,
              description: semester.description,
              onTap: () => onSemesterSelected(semester),
            ),
        ],
      ),
    );
  }
}