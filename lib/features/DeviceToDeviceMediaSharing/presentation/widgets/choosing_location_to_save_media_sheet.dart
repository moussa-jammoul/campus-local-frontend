import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/semester/form.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/widgets/semester_sheet.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/widgets/sheet_course_page.dart';
import 'package:flutterfrontenduniprojectmanager/router/router.dart';

// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
typedef SaveLocation = ({String semesterUuid, String courseUuid});

class ChoosingLocationToSaveMediaSheet extends ConsumerStatefulWidget {
  const ChoosingLocationToSaveMediaSheet({super.key});


  static Future<SaveLocation?> show() {
    final context = navigatorKey.currentContext;
    if (context == null) return Future.value(null);

    return showModalBottomSheet<SaveLocation>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (_) => const ChoosingLocationToSaveMediaSheet(),
    );
  }

  @override
  ConsumerState<ChoosingLocationToSaveMediaSheet> createState() =>
      _ChoosingLocationToSaveMediaSheetState();
}

class _ChoosingLocationToSaveMediaSheetState
    extends ConsumerState<ChoosingLocationToSaveMediaSheet> {
  
  final double _sheetHeight = 450;
  final double _blurSigma = 20;
  final double _surfaceAlpha = 0.6;

  Semester? _selectedSemester;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final media = MediaQuery.of(context);
    final bottomSpace = media.viewInsets.bottom + media.padding.bottom + 8;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _blurSigma, sigmaY: _blurSigma),
        child: Container(
          height: _sheetHeight,
          padding: EdgeInsets.only(bottom: bottomSpace),
          decoration: BoxDecoration(
            color: scheme.surface.withValues(alpha: _surfaceAlpha),
            border: Border(
              top: BorderSide(
                color: scheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: scheme.onSurfaceVariant.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              _buildHeader(context, scheme),
              Expanded(
                child: _selectedSemester == null
                    ? SheetSemestersPage(
                        onSemesterSelected: (semester) =>
                            setState(() => _selectedSemester = semester),
                      )
                    : SheetCoursesPage(
                        
                        key: ValueKey(_selectedSemester!.uuid),
                        semester: _selectedSemester!,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ColorScheme scheme) {
    final semester = _selectedSemester;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      child: Row(
        children: [
          if (semester != null)
            IconButton(
              icon: const Icon(Icons.arrow_back),
              color: scheme.onSurface,
              onPressed: () => setState(() => _selectedSemester = null),
            )
          else
            const SizedBox(width: 18),
          Expanded(
            child: Text(
              semester == null ? 'Choose Where you want to save the media' : semester.semesterName,      
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}