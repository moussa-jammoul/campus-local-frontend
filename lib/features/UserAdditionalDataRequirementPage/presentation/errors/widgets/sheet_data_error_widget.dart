import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/UserAdditionalDataRequirementPage/presentation/errors/providers/sheet_data_error_provider.dart';

class SheetFillErrorsWidget extends ConsumerWidget {
  const SheetFillErrorsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final errorMessage = ref.watch(sheetDataErrorsProvider);
    if (errorMessage == null) {
      return const SizedBox.shrink();
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 18),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.red, fontSize: 13),
          ),
        ),
      ],
    );

  }

}