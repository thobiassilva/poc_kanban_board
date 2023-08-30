import 'package:flutter/material.dart';
import 'package:poc_drag_and_drop/kanban_card_widget.dart';
// import 'package:poc_drag_and_drop/todo_entity.dart';

class KanbanColumn<T extends Object> extends StatefulWidget {
  final bool Function(int columnIndex, T?) onWillAccept;
  final Color backgroundColor;
  final String title;
  final List<KanbanCard<T>> cards;
  final bool expanded;
  final int columnIndex;

  const KanbanColumn({
    super.key,
    required this.onWillAccept,
    required this.columnIndex,
    required this.title,
    required this.cards,
    required this.backgroundColor,
    this.expanded = true,
  });

  @override
  State<KanbanColumn<T>> createState() => _KanbanColumnState<T>();
}

class _KanbanColumnState<T extends Object> extends State<KanbanColumn<T>> {
  Widget mapItemToCard(KanbanCard<T> kanbanCard) {
    return Draggable<T>(
      data: kanbanCard.value,
      feedback: Transform.scale(
        scale: 0.9,
        child: kanbanCard.child,
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: kanbanCard.child,
      ),
      child: kanbanCard.child,
      // onDragStarted: () {
      //   print('onDragStarted');
      // },
      // onDragUpdate: (details) {
      //   print('onDragUpdate');
      // },
      // onDragEnd: (details) {
      //   print('onDragEnd');
      // },
      // onDraggableCanceled: (velocity, offset) {
      //   print('onDraggableCanceled');
      // },
      // onDragCompleted: () {
      //   print('onDragCompleted');
      // },
    );
  }

  bool canShowTargedArea(List<T?> candidateData) =>
      candidateData.isNotEmpty &&
      widget.cards.every((card) => card.value != candidateData.firstOrNull);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: widget.backgroundColor,
      ),
      child: DragTarget<T>(
        onAccept: (data) {},
        onWillAccept: (data) => widget.onWillAccept(widget.columnIndex, data),
        builder: (context, candidateData, rejectedData) {
          return Column(
            mainAxisSize: widget.expanded ? MainAxisSize.max : MainAxisSize.min,
            children: [
              _Header(
                title: widget.title,
                count: widget.cards.length,
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Column(
                    children: [
                      if (canShowTargedArea(candidateData))
                        const AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Card(
                            color: Colors.white10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: Text('Solte aqui'),
                            ),
                          ),
                        ),
                      ...widget.cards.map(mapItemToCard)
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final int count;

  const _Header({
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.black12,
            ),
            child: Text(title),
          ),
          Text('$count'),
        ],
      ),
    );
  }
}
