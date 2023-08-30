enum ETaskStatus {
  toDo,
  doing,
  finished,
}

class TaskEntity {
  final String title;
  final ETaskStatus status;

  TaskEntity({
    required this.title,
    this.status = ETaskStatus.toDo,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskEntity &&
        other.title == title &&
        other.status == status;
  }

  @override
  int get hashCode => title.hashCode ^ status.hashCode;
}
