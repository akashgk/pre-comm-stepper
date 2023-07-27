import 'package:flutter/material.dart';

enum Status { completed, pending, inProgress }

@immutable
class StageItem {
  final String name;
  final int index;
  final Status status;

  const StageItem({
    required this.name,
    required this.index,
    this.status = Status.pending,
  });

  StageItem copyWith({
    String? name,
    int? index,
    Status? status,
  }) {
    return StageItem(
      name: name ?? this.name,
      index: index ?? this.index,
      status: status ?? this.status,
    );
  }
}
