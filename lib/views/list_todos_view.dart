import 'package:flutter/material.dart';
import 'package:todo_flutter_gql_demo/model/todo.dart';

class ListTodosView extends StatelessWidget {
  final List<Todo> todoItems;
  final onTodoToggle;
  final reloadTodoList;

  ListTodosView(
      {@required this.todoItems,
      @required this.onTodoToggle,
      @required this.reloadTodoList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Reload List',
            onPressed: () {
              this.reloadTodoList();
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: todoItems.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              title: Text(todoItems[index].getName()),
              value: todoItems[index].isCompleted(),
              onChanged: (_) => onTodoToggle(todoItems[index]),
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/addtodo'),
          child: Icon(Icons.add)),
    );
  }
}
