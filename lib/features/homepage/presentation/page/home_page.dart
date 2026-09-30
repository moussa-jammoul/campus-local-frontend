import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/semester/semester_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/userAdditionalData/additionalDataFromLogin/addional_data_from_login.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/widgets/app_bar_glacier.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/widgets/semesters_home.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    ref.read(semesterProvider.notifier).readData(FirebaseAuth.instance.currentUser!.uid);
  }
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: CustomScrollView(
        slivers: [
          // Frosted Glass Sliver App Bar
          const AppBarGlacier(),

          // Main Page Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  HeaderGreetingSection(),
                  SizedBox(height: 24),
                  SemestersHome(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}