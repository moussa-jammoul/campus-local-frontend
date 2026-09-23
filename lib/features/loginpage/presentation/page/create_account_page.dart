// ignore: implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/presentation/errors/widgets/create_account_errors_widget.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/service/login_service.dart';
import 'package:flutterfrontenduniprojectmanager/router/router.dart';
import 'package:logger/logger.dart';



Future<void> showCreateAccountSheet() async {
  final context = navigatorKey.currentContext;
  if (context == null) return;

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true, 
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => const CreateAccountSheet(),
  );
}



class CreateAccountSheet extends ConsumerStatefulWidget {
  const CreateAccountSheet({super.key});

  @override
  ConsumerState<CreateAccountSheet> createState() => _CreateAccountSheetState();
}

class _CreateAccountSheetState extends ConsumerState<CreateAccountSheet> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordRepeatController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _majorController = TextEditingController();

  int? _day;
  int? _month;
  int? _year;

  String _role = 'student';
  bool _submitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordRepeatController.dispose();
    _fullNameController.dispose();
    _majorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Push content above the keyboard when it appears.
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Drag handle, standard Material bottom sheet affordance.
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.outline,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _passwordRepeatController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Repeat password'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(labelText: 'Full name'),
                ),
                const SizedBox(height: 12),

                const Text('Date of Birth'),
                const SizedBox(height: 5,),
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
                CreateAccountErrorsWidget(),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitting ? null : _submit,
                  child: _submitting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Create Account'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _submit() async {
    final String? dob;
    if(_day == null || _month == null || _year == null){
      dob = null;
    }
    else{
    dob = '$_day-$_month-$_year';
    }
    setState(() => _submitting = true);

    

    try {
      await createAccount(
        _emailController.text,
        _passwordController.text,
        _passwordRepeatController.text,
        _fullNameController.text,
        dob,
        _role,
        _majorController.text,
        ref,
      );
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }
}

Future<void> createAccount(
  String email,
  String password,
  String passwordRepeated,
  String fullName,
  String? dateOfBirth,
  String role,
  String major,
  WidgetRef ref,
) async {
  await ref.read(loginServiceProvider.notifier).createAccount(
        email,
        password,
        passwordRepeated,
        fullName,
        dateOfBirth,
        role,
        major,
      );
}