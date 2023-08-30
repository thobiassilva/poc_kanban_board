import 'package:flutter/material.dart';
import 'package:poc_drag_and_drop/kanban_column_widget.dart';

class KanbanBoard extends StatelessWidget {
  final List<KanbanColumn> columns;

  const KanbanBoard({
    super.key,
    required this.columns,
  });

  /// Adiciona espaçamento entre as colunas
  List<Widget> get columnsWithSpaces => columns.expand((KanbanColumn column) {
        return [
          column,
          const SizedBox.square(dimension: 20),
        ];
      }).toList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columnsWithSpaces,
      ),
    );
  }
}
