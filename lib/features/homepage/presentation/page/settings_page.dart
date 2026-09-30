import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/widgets/fetsh_any_missed_media_button.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/widgets/light_dark_mode_switcher.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/widgets/linked_accounts.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/widgets/logout_tile.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/widgets/open_connection_to_send_media.dart';

const double kSettingsWidth = 320;


const double toolbarheight = 80;
class SettingsPage extends ConsumerWidget {
  
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        toolbarHeight: toolbarheight,
        scrolledUnderElevation: 0,
        backgroundColor: scheme.surface.withValues(alpha: 0.25), 
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: const SizedBox.expand(
              child: ColoredBox(color: Colors.transparent),
            ),
          ),
        ),
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
        ),
        centerTitle: true,
      ),
        body:  Center(

          child: SingleChildScrollView(
  
            padding: const EdgeInsets.only(top:toolbarheight + 40 , bottom: 40),

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,

              crossAxisAlignment: CrossAxisAlignment.center,

              children: const [

                LinkedAccountsTiles(),

                FetshAnyMissedMediaButton(),

                OpenConnectionToSendMedia(),

                AppearanceTile(),

                LogoutButton(),

              ],

            ),

          ),

        ),
    );
  }
}