
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/userAdditionalData/additionalDataFromLogin/addional_data_from_login.dart';

class AppBarGlacier extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarGlacier({super.key});

  static const double _radius = 28;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final userdata = ref.watch(additionalDataFromLoginProvider);

    const borderRadius = BorderRadius.vertical(
      bottom: Radius.circular(_radius),
    );

    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: scheme.surface.withValues(alpha: 0.15), 
            borderRadius: borderRadius,
            border: Border(
              bottom: BorderSide(
                color: scheme.onSurface.withValues(alpha:0.1),
              ),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
             
                  IconButton(
                    icon: const Icon(Icons.logout_rounded),
                    color: scheme.onSurface,
                    onPressed: () {
                      // TODO: logout
                    },
                  ),

              
                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: scheme.primary,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: scheme.primaryContainer,
                             
                              child: Icon(
                                Icons.person,
                                size: 18,
                                color: scheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              userdata?.fullname ?? "loading...",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: scheme.onSurface),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

             
                  IconButton(
                    icon: const Icon(Icons.settings_rounded),
                    color: scheme.onSurface,
                    onPressed: () {
                      // TODO: settings
                    },
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

