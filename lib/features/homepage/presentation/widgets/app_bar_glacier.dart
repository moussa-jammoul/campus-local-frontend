
// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/userAdditionalData/additionalDataFromLogin/addional_data_from_login.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/widgets/card_style.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/service/home_page_services.dart';
import 'package:go_router/go_router.dart';

class AppBarGlacier extends ConsumerWidget {
  const AppBarGlacier({super.key});

  Future<void> logOut(BuildContext context, WidgetRef ref) async {
    final logout = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Sign Out',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );

    if (logout == true && context.mounted) {
      ref.read(homePageServiceProvider.notifier).logOut();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final userdata = ref.watch(additionalDataFromLoginProvider);

    return SliverAppBar(
      pinned: true,
      expandedHeight: 80,
      scrolledUnderElevation: 0,
      toolbarHeight: 70,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            decoration: BoxDecoration(
              color: scheme.surface.withValues(alpha: 0.25),
              border: Border(
                bottom: BorderSide(
                  color: scheme.onSurface.withValues(alpha: 0.08),
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: scheme.primaryContainer,
                          child: Icon(
                            Icons.person_rounded,
                            size: 22,
                            color: scheme.onPrimaryContainer,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: scheme.surface, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    
                    // User Title Info
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back,',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: scheme.onSurface.withValues(alpha: 0.6),
                                ),
                          ),
                          Text(
                            userdata?.fullname ?? "Loading...",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: scheme.onSurface,
                                ),
                          ),
                        ],
                      ),
                    ),

                    // Actions
                    IconButton(
                      icon: const Icon(Icons.settings_outlined, size: 20),
                      onPressed: () => context.go('/home/settings'),
                     
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      icon: Icon(Icons.logout_rounded, size: 20, color: scheme.error),
                      onPressed: () => logOut(context, ref),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderGreetingSection extends StatelessWidget {
  const HeaderGreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return CardStyleWidget(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Container(
              width: 4,
              height: 70,
              decoration: BoxDecoration(
                color: scheme.primary,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 14),

            // Header text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Academic Overview',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.4,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Track your enrolled courses, progress, and schedules , completely offline !.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant.withValues(alpha: 0.8),
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}