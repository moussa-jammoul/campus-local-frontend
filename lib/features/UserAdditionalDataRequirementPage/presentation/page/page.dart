
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/userAdditionalData/additionalDataFromLogin/form.dart';
import 'package:flutterfrontenduniprojectmanager/features/UserAdditionalDataRequirementPage/presentation/errors/widgets/sheet_data_error_widget.dart';
import 'package:flutterfrontenduniprojectmanager/features/UserAdditionalDataRequirementPage/presentation/widgets/graduate_lottie.dart';
import 'package:flutterfrontenduniprojectmanager/features/UserAdditionalDataRequirementPage/service/addtional_data_service.dart';


class UserAdditionalDataRequirementPage extends ConsumerStatefulWidget {
  const UserAdditionalDataRequirementPage({super.key});

  @override
  ConsumerState<UserAdditionalDataRequirementPage> createState() =>
      _UserAdditionalDataRequirementPageState();
}

class _UserAdditionalDataRequirementPageState
    extends ConsumerState<UserAdditionalDataRequirementPage> {
  final _fullNameController = TextEditingController();
  final _majorController = TextEditingController();

  int? _day;
  int? _month;
  int? _year;

  String _role = 'student';

  @override
  void dispose() {
    _fullNameController.dispose();
    _majorController.dispose();
    super.dispose();
  }

  Future<void> _showCantLeaveDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Complete your profile'),
        content: const Text(
          'Please finish filling in your information before continuing. This step is required to set up your account.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
    if (didPop) return;
    _showCantLeaveDialog();
  },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // no back button
          title: const Text('Complete your profile'),
        ),
        body: SafeArea(
          child: Center( 
            child:SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Center(
                child:GraduateLottieCompleteProfile(),
                ),
                
                TextField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(labelText: 'Full name'),
                ),
                const SizedBox(height: 12),

                const Text('Date of Birth'),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        key: const ValueKey('dob_day'),
                        initialValue: _day,
                        decoration: const InputDecoration(labelText: 'Day'),
                        items: List.generate(31, (i) => i + 1)
                            .map((d) => DropdownMenuItem(value: d, child: Text('$d')))
                            .toList(),
                        onChanged: (value) => setState(() => _day = value),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        key: const ValueKey('dob_month'),
                        initialValue: _month,
                        decoration: const InputDecoration(labelText: 'Month'),
                        items: List.generate(12, (i) => i + 1)
                            .map((m) => DropdownMenuItem(value: m, child: Text('$m')))
                            .toList(),
                        onChanged: (value) => setState(() => _month = value),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        key: const ValueKey('dob_year'),
                        initialValue: _year,
                        decoration: const InputDecoration(labelText: 'Year'),
                        items: List.generate(
                          DateTime.now().year - 1950 + 1,
                          (i) => DateTime.now().year - i,
                        ).map((y) => DropdownMenuItem(value: y, child: Text('$y'))).toList(),
                        onChanged: (value) => setState(() => _year = value),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  key: const ValueKey('role_dropdown'),
                  initialValue: _role,
                  decoration: const InputDecoration(labelText: 'Role'),
                  items: const [
                    DropdownMenuItem(value: 'student', child: Text('Student')),
                    DropdownMenuItem(value: 'professor', child: Text('Professor')),
                  ],
                  onChanged: (value) => setState(() => _role = value ?? 'student'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _majorController,
                  decoration: const InputDecoration(labelText: 'Major'),
                ),
                const SizedBox(height: 8,),
                SheetFillErrorsWidget(),
                const SizedBox(height: 24),
                Center(
                child:
                SizedBox(
                  width: double.infinity,
                child:ElevatedButton(
                  
                  onPressed: () {
                    final String dob;
                    if (_day == null || _month == null || _year == null) {
                      dob = '0-00-000';
                    } else {
                      dob = '$_day-$_month-$_year';
                    }
                    if (FirebaseAuth.instance.currentUser != null) {
                      unawaited(ref.read(additionalDataServiceProvider.notifier).submit(
                            UserAdditionalData(
                              uid: FirebaseAuth.instance.currentUser!.uid,
                              email: FirebaseAuth.instance.currentUser!.email!,
                              fullname: _fullNameController.text,
                              dateOfBirth: dob,
                              role: _role,
                              major: _majorController.text,
                            ),
                          ));
                    }
                  },
                  child: const Text('Done'),
                ),
                )
                )
              ],
            ),
          ),
          )
        ),
      ),
    );
  }
}