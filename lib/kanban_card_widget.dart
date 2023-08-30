// class KanbanCard extends StatelessWidget {
//   final Widget child;

//   const KanbanCard({
//     super.key,
//     required this.child,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Draggable(
//       feedback: child,
//       childWhenDragging: const SizedBox(),
//       child: child,
//       onDragStarted: () {},
//       onDragEnd: (details) {},
//     );
//   }
// }

import 'package:flutter/material.dart';

class KanbanCard<T> {
  final T value;
  final Widget child;

  const KanbanCard({
    required this.value,
    required this.child,
  });
}
