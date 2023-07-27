import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/stage_item.dart';

List<StageItem> initialStageList = [
  const StageItem(name: 'General', index: 0, status: Status.inProgress),
  const StageItem(name: 'Shipping', index: 1),
  const StageItem(name: 'Parties', index: 2),
  const StageItem(name: 'Bank', index: 3),
  const StageItem(name: 'Beneficiary', index: 4),
  const StageItem(name: 'Addres', index: 5),
  const StageItem(name: 'Preview', index: 6),
];

List<StageItem> initialStageList2 = [
  const StageItem(name: 'General', index: 0, status: Status.inProgress),
  const StageItem(name: 'Shipping', index: 1),
  const StageItem(name: 'Parties', index: 2),
  const StageItem(name: 'Bank', index: 3),
];

final currentActiveStage = StateProvider<int>((ref) => 0);

final _stageListProvider =
    StateProvider<List<StageItem>>((ref) => initialStageList);

final _stageListProvider2 =
    StateProvider<List<StageItem>>((ref) => initialStageList2);

class StageManager {
  final ProviderRef ref;
  final StateProvider<List<StageItem>> stageProvider;
  const StageManager(this.ref, {required this.stageProvider});

  List<StageItem> get stageList => ref.watch(stageProvider);

  int _currentStageIndex() {
    return ref.watch(currentActiveStage);
  }

  StageItem get _currentStageItem => stageList[_currentStageIndex()];

  StageItem? get _nextStageItem {
    int index = _currentStageIndex();
    if (index + 1 < stageList.length) {
      return stageList[index + 1];
    }
    return null;
  }

  StageItem? get _previousStageItem {
    int index = _currentStageIndex();
    if (index - 1 >= 0) {
      return stageList[index - 1];
    }
    return null;
  }

  void goToNextStage() {
    try {
      List<StageItem> newStageList = stageList;
      newStageList[_currentStageIndex()] =
          _currentStageItem.copyWith(status: Status.completed);

      if (_currentStageIndex() + 1 < stageList.length) {
        newStageList[_currentStageIndex() + 1] =
            _nextStageItem!.copyWith(status: Status.inProgress);
      }
      ref.read(stageProvider.notifier).update((state) => newStageList);
      ref
          .read(currentActiveStage.notifier)
          .update((state) => _currentStageIndex() + 1);
    } catch (e) {
      log(e.toString());
    }
  }

  void goToPreviousStage() {
    try {
      List<StageItem> newStageList = stageList;
      newStageList[_currentStageIndex()] =
          _currentStageItem.copyWith(status: Status.pending);

      if (_currentStageIndex() - 1 >= 0) {
        newStageList[_currentStageIndex() - 1] =
            _previousStageItem!.copyWith(status: Status.inProgress);
      }
      ref.read(stageProvider.notifier).update((state) => newStageList);
      ref
          .read(currentActiveStage.notifier)
          .update((state) => _currentStageIndex() - 1);
    } catch (e) {
      log(e.toString());
    }
  }

  void goToStage() {}
}

final list1ManagerProvider =
    Provider((ref) => StageManager(ref, stageProvider: _stageListProvider));

final list2ManagerProvider =
    Provider((ref) => StageManager(ref, stageProvider: _stageListProvider2));
