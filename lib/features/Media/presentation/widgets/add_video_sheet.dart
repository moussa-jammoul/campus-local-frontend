import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/media_services.dart';
import 'package:path/path.dart' as p;   // for p.basename

class AddVideoBottomSheetContent extends ConsumerStatefulWidget {
  const AddVideoBottomSheetContent({super.key});

  @override
  ConsumerState<AddVideoBottomSheetContent> createState() {
    return _AddVideoBottomSheetContentState();
  }
}

class _AddVideoBottomSheetContentState
    extends ConsumerState<AddVideoBottomSheetContent> {
  final allowedFormat =  ['mp4', 'mov' , 'mkv' , 'avi'];
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _fileName;   // shown under the icon once a video is picked
  String? _sourcePath;
  String? _type;
  bool _showPickError = false;
  

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  InputDecoration _decoration(
    ColorScheme scheme,
    String label,
    String hint,
    IconData icon,
  ) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, size: 20),
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
    );
  }

  Future<void> _pickVideo() async {
    final data = await ref
        .read(mediaServiceProvider.notifier)
        .pickVideo(allowedFormat);

    if (data != null && data.$1 != null) {
      setState(() {
        _sourcePath = data.$1;
        _type = data.$2;
        _fileName = p.basename(data.$1!);
        _showPickError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: scheme.surface.withValues(alpha: 0.85),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border(
              top: BorderSide(
                color: scheme.onSurface.withValues(alpha: 0.12),
                width: 1,
              ),
            ),
          ),
          padding: EdgeInsets.fromLTRB(20, 12, 20, 20 + bottomInset),
          child: SingleChildScrollView(
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
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: scheme.onSurfaceVariant.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // Header Title
                  Text(
                    'Add New Video',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Video picker
                  GestureDetector(
                    onTap: _pickVideo,
                    child: Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHigh.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _showPickError
                              ? scheme.error
                              : scheme.outlineVariant.withValues(alpha: 0.5),
                          width: 1.5,
                        ),
                      ),
                      child: _fileName == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.video_call_outlined,
                                  size: 40,
                                  color: scheme.primary,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Tap to pick a video',
                                  style: textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: scheme.onSurface,
                                  ),
                                ),
                              ],
                            )
                          : Stack(
                              fit: StackFit.expand,
                              children: [
                                // no thumbnail yet: a video icon + the file name
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.movie_rounded,
                                        size: 48,
                                        color: scheme.primary,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        _fileName!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: scheme.onSurface,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: scheme.surface.withValues(alpha: 0.85),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.edit,
                                            size: 14, color: scheme.primary),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Change',
                                          style: textTheme.labelSmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: scheme.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  if (_showPickError)
                    Padding(
                      padding: const EdgeInsets.only(top: 6, left: 12),
                      child: Text(
                        'Please pick a video',
                        style: textTheme.bodySmall?.copyWith(color: scheme.error),
                      ),
                    ),
                  const SizedBox(height: 16),

                  // Name
                  TextFormField(
                    controller: _nameController,
                    textCapitalization: TextCapitalization.words,
                    style: textTheme.bodyMedium?.copyWith(color: scheme.onSurface),
                    decoration: _decoration(
                      scheme,
                      'Video Name',
                      'e.g. Lecture 1 Recording',
                      Icons.title_rounded,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a video name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),

                  // Description (optional)
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 2,
                    minLines: 1,
                    textCapitalization: TextCapitalization.sentences,
                    style: textTheme.bodyMedium?.copyWith(color: scheme.onSurface),
                    decoration: _decoration(
                      scheme,
                      'Description (Optional)',
                      'Brief note about this video...',
                      Icons.description_rounded,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Save
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        final formOk = _formKey.currentState?.validate() ?? false;

                        if (_sourcePath == null) {
                          setState(() => _showPickError = true);
                          return;
                        }
                        if (!formOk) return;

                        Navigator.of(context).pop((
                          sourcePath: _sourcePath,
                          description: _descriptionController.text.trim().isEmpty
                              ? null
                              : _descriptionController.text.trim(),
                          videoName: _nameController.text.trim(),
                          type: _type,
                        ));
                      },
                      child:  Text(
                        'Save Video',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: scheme.onPrimary,
                        ),
                      ) ,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}