import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:poc_drag_and_drop/kanban_board_widget.dart';
import 'package:poc_drag_and_drop/kanban_card_widget.dart';
import 'package:poc_drag_and_drop/kanban_column_widget.dart';
import 'package:poc_drag_and_drop/task_entity.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poc Kanban',
      scrollBehavior: const CustomScrollBehavior(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool onWillAccept(int index, TaskEntity? entity) {
    if (entity == null) return false;
    final res = index > entity.status.index;
    print('res:$res - index:$index - entity:${entity.status.index}');
    return res;
  }

  List<TaskEntity> tasks = [
    TaskEntity(title: 'Task 1'),
    TaskEntity(title: 'Task 2'),
  ];

  KanbanCard<TaskEntity> mapTaskToKanbanCard(TaskEntity task) {
    return KanbanCard(
      child: _MyCard(task),
      value: task,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KanbanBoard(
        columns: [
          KanbanColumn<TaskEntity>(
            title: 'To Do',
            columnIndex: 0,
            cards: tasks
                .where((task) => task.status == ETaskStatus.toDo)
                .map(mapTaskToKanbanCard)
                .toList(),
            backgroundColor: Colors.blueAccent.shade100,
            onWillAccept: onWillAccept,
          ),
          KanbanColumn<TaskEntity>(
            title: 'Doing',
            columnIndex: 1,
            cards: tasks
                .where((task) => task.status == ETaskStatus.doing)
                .map(mapTaskToKanbanCard)
                .toList(),
            backgroundColor: Colors.amberAccent.shade100,
            onWillAccept: onWillAccept,
          ),
          KanbanColumn<TaskEntity>(
            title: 'Finished',
            cards: tasks
                .where((task) => task.status == ETaskStatus.finished)
                .map(mapTaskToKanbanCard)
                .toList(),
            columnIndex: 2,
            backgroundColor: Colors.greenAccent.shade100,
            onWillAccept: onWillAccept,
          ),
        ],
      ),
    );
  }
}

class _MyCard extends StatelessWidget {
  final TaskEntity todo;
  const _MyCard(this.todo);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: ColoredBox(
            color: Colors.white,
            child: Center(
              child: Text(todo.title),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  const CustomScrollBehavior();
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
