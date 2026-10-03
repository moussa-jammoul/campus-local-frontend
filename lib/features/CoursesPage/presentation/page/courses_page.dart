import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/courses_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/semester/form.dart';
import 'package:flutterfrontenduniprojectmanager/features/CoursesPage/presentation/widgets/app_bar_glacier.dart';
import 'package:flutterfrontenduniprojectmanager/features/CoursesPage/presentation/widgets/courses_home.dart';

class CoursesPage extends ConsumerStatefulWidget {
  final Semester semester;
  const CoursesPage({super.key, required this.semester});

  @override
  ConsumerState<CoursesPage> createState() {
    return _CoursesPageState();
  }
}

class _CoursesPageState extends ConsumerState<CoursesPage> {
  ///function used to read stored courses, with
  ///retry logique if any thing goes wrong with the user
  ///e.g uid not initialized yet
  Future<void> readLocalCourses() async {
    bool loaded = false;
    while (!loaded) {
      if (FirebaseAuth.instance.currentUser != null) {
        ref.read(courseProvider.notifier).readData(
              FirebaseAuth.instance.currentUser!.uid,
              widget.semester.uuid!,
            );
        loaded = true;
      } else {
        //wait 5 second then retry
        await Future.delayed(const Duration(seconds: 5));
      }
    }
  }

  @override
  void initState() {
    super.initState();

    //init courses
    unawaited(readLocalCourses());
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: CustomScrollView(
        slivers: [
          CourseAppBarGlacier(semesterName: widget.semester.semesterName),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CoursesHome(semester: widget.semester),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}