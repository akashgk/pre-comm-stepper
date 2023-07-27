import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/list_pro.dart';

class FormBody extends ConsumerWidget {
  const FormBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
          ),
          onPressed: () {
            ref.read(list1ManagerProvider).goToNextStage();
          },
          child: const Text(
            "Go To Next",
            style: TextStyle(color: Colors.black),
          ),
        ),
        const SizedBox(height: 200),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              ref.read(list1ManagerProvider).goToPreviousStage();
            },
            child: const Text("Go To previous")),
      ],
    );
  }
}
