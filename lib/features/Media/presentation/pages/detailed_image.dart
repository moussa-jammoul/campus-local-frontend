import 'dart:ffi';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:go_router/go_router.dart';


const double ktoolbarheightAppbar = 40;

class DetailedImage extends ConsumerWidget {
  const DetailedImage({super.key, required this.binary , required this.imageDetail});

  final Uint8List? binary;  
  final MediaForm imageDetail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: ktoolbarheightAppbar,
  backgroundColor: Colors.transparent,
  elevation: 0,
  scrolledUnderElevation: 0,       
  automaticallyImplyLeading: true,
  actions: [
    IconButton(
      onPressed: () {
        //TODO : show image details , which include to add to favorite and edit the details
      },
      icon: const Icon(Icons.arrow_drop_down_sharp),
    ),
  ],
),
      body: 
      
      Center(
        
        child:
         binary == null
            ? _brokenImage(scheme)
            : InteractiveViewer(
                minScale: 1,
                maxScale: 5,
                child: Image.memory(
                  binary!,
                  fit: BoxFit.contain,       // now it scales to the full available area
                  width: double.infinity,
                  height: double.infinity,

                  
                  errorBuilder: (context, error, stackTrace) => _brokenImage(scheme),
                ),
              ),
      ),
      
    );
  }

  Widget _brokenImage(ColorScheme scheme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.broken_image_outlined, size: 64, color: scheme.outline),
        const SizedBox(height: 12),
        Text(
          'Image could not be loaded or it does not exist in the current device',
          style: TextStyle(color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }
}