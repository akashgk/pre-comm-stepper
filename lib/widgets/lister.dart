import 'package:flutter/material.dart';
import 'package:no/models/stage_item.dart';

Icon getIconForStatus(Status status) {
  switch (status) {
    case Status.completed:
      return const Icon(Icons.check);
    case Status.inProgress:
      return const Icon(Icons.watch_outlined);
    case Status.pending:
      return const Icon(Icons.pending);
  }
}

class Listerrs extends StatelessWidget {
  final List<StageItem> stages;
  const Listerrs({super.key, required this.stages});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            width: 20,
            height: 60,
            color: Colors.red,
          );
        },
        itemBuilder: (context, index) => Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: getIconForStatus(stages[index].status),
        ),
        itemCount: stages.length,
      ),
    );
  }
}
