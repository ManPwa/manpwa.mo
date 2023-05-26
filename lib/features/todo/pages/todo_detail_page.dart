import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_remoter/flutter_remoter.dart';
import 'package:get_it/get_it.dart';

import '../../../api/index.dart';

class TodoDetailPage extends StatefulWidget {
  static const routeName = 'todo/detail';
  static const routePath = ':$kTodoIdParam';
  static const kTodoIdParam = 'todoId';

  final String todoId;

  const TodoDetailPage({super.key, required this.todoId});

  @override
  State<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoterQuery<Todo>(
        remoterKey: jsonEncode(['todo', 'item', widget.todoId]),
        execute: () async {
          final todoApi = GetIt.I.get<TodoApi>();
          return todoApi.getTodoItem(todoId: widget.todoId);
        },
        disabled: false,
        builder: (context, snapshot, utils) {
          if (snapshot.status == RemoterStatus.fetching) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.status == RemoterStatus.error) {
            final error = snapshot.error;
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    error.toString(),
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  FilledButton.tonalIcon(
                    onPressed: () {
                      utils.retry();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  )
                ],
              ),
            );
          }

          final todoItem = snapshot.data!;
          return CustomScrollView(
            slivers: [
              SliverAppBar.medium(
                title: Text(
                  todoItem.title,
                  style: TextStyle(
                    decoration: todoItem.completed
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                centerTitle: false,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
            ],
          );
        },
      ),
    );
  }
}
