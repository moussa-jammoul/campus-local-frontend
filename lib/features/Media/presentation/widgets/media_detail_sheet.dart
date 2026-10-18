

import 'dart:async';
import 'dart:ui'; 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/ImageService/media_image_service.dart';



///this function we can used for any type of media ,it doesn't care if it is an image , video , or any file type
class MediaDetailSheet extends ConsumerStatefulWidget {
  const MediaDetailSheet({super.key, required this.media});

  final MediaForm media;

  static Future<void> show(BuildContext context, MediaForm media) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (_) => MediaDetailSheet(media: media),
    );
  }

  @override
  ConsumerState<MediaDetailSheet> createState() => _MediaDetailSheetState();
}

class _MediaDetailSheetState extends ConsumerState<MediaDetailSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late bool _isFavorite;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    
    _nameController = TextEditingController(text: widget.media.filename);
    _descriptionController =
        TextEditingController(text: widget.media.fileDescription ?? '');
    _isFavorite = widget.media.isFavorite;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String _formatSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    final d = date.toLocal();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${d.year}-${two(d.month)}-${two(d.day)} ${two(d.hour)}:${two(d.minute)}';
  }

  InputDecoration _fieldDecoration(ColorScheme scheme, String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _infoRow(BuildContext context, String label, String value) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
          Expanded(
            child: SelectableText(value, style: textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final media = widget.media;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: scheme.surface.withValues(alpha: 0.75),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)), 
            border: Border(
              top: BorderSide(color: scheme.onSurface.withValues(alpha: 0.08)),
              
            ),
          ),
       
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // drag handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: scheme.onSurface.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Details',
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() => _isFavorite = !_isFavorite);
                           unawaited(ref.read(mediaImageServiceProvider.notifier).updateMedia(
                          media.copyWith(
                            isFavorite: _isFavorite
                          )
                        ));
                        },
                        icon: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: _isFavorite ? Colors.redAccent : scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        controller: _nameController,
        decoration: _fieldDecoration(scheme, 'Name'),
        textInputAction: TextInputAction.next,
        maxLength: 100,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Name cannot be empty';
          }
          return null;                       
        },
      ),
      const SizedBox(height: 12),
      TextFormField(
        controller: _descriptionController,
        decoration: _fieldDecoration(scheme, 'Description'),
        minLines: 2,
        maxLines: 5,
        maxLength: 500,
        // no validator: the description is optional
      ),
    ],
  ),
),
                  const SizedBox(height: 16),

                  _infoRow(context, 'Path', media.filepath),
                  _infoRow(context, 'Type', media.filetype),
                  _infoRow(context, 'Size', _formatSize(media.filesizeByte)),
                  _infoRow(context, 'Added', _formatDate(media.createdAt)),
                  _infoRow(context, 'Updated', _formatDate(media.updatedAt)),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;   

                        final name = _nameController.text.trim();
                        final description = _descriptionController.text.trim();
                        unawaited(ref.read(mediaImageServiceProvider.notifier).updateMedia(
                          media.copyWith(
                            fileDescription: description,
                            filename: name
                          )
                        ));
                        Navigator.of(context).pop();
                      },
                      child: const Text('Save changes'),
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