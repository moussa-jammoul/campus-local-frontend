// ignore_for_file: unused_field

import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/ImageService/media_image_service.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/media_services.dart';

class AddImageBottomSheetContent extends ConsumerStatefulWidget {
  const AddImageBottomSheetContent({super.key});

  @override
  ConsumerState<AddImageBottomSheetContent> createState() {
    return _AddImageBottomSheetContentState();
  }

}

class _AddImageBottomSheetContentState
    extends ConsumerState<AddImageBottomSheetContent> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  
  Uint8List? _imageBytes;
  String? _sourcePath;
  String? _type;

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
                    'Add New Image',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),

                 
                  GestureDetector(
                    onTap: () async {
                      final data = await ref.read(mediaServiceProvider.notifier).pickImage(['png' , 'jpg']);
                       if(data != null){
                       setState(() {
                       _imageBytes = data.$2;
                         _sourcePath = data.$1;
                         _type = data.$3;
                       });
                       }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHigh.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: scheme.outlineVariant.withValues(alpha: 0.5),
                          width: 1.5,
                        ),
                      ),
                      child: _imageBytes == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 40,
                                  color: scheme.primary,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Tap to pick an image',
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
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.memory(
                                    _imageBytes!,
                                    fit: BoxFit.cover,
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
                  const SizedBox(height: 16),

                  
                  TextFormField(
                    controller: _nameController,
                    textCapitalization: TextCapitalization.words,
                    style: textTheme.bodyMedium?.copyWith(color: scheme.onSurface),
                    decoration: InputDecoration(
                      labelText: 'Image Name',
                      hintText: 'e.g. Chapter 1 Slide',
                      prefixIcon: const Icon(Icons.title_rounded, size: 20),
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
                        return 'Please enter an image name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),

                  
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 2,
                    minLines: 1,
                    textCapitalization: TextCapitalization.sentences,
                    style: textTheme.bodyMedium?.copyWith(color: scheme.onSurface),
                    decoration: InputDecoration(
                      labelText: 'Description (Optional)',
                      hintText: 'Brief note about this image...',
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
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          Navigator.of(context).pop((
                            sourcePath: _sourcePath,
                            description: _descriptionController.text.trim().isEmpty
                                ? null
                                : _descriptionController.text.trim(),
                            imageName: _nameController.text.trim(),
                            type : _type
                          ));
                        }
                      },
                      child: Text(
                        'Save Image',
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
      ),
    );
  }
}