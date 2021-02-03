import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

// Models
import 'package:todo_flutter_gql_demo/model/todo.dart';

// Views
import 'package:todo_flutter_gql_demo/views/list_todos_view.dart';
import 'package:todo_flutter_gql_demo/views/add_todo_view.dart';

// Amplify configuration
import 'amplifyconfiguration.dart';

// Random Number Utility
import 'dart:math';

Random randomNumber = new Random();

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TodoWidget();
  }
}

class TodoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoListState();
  }
}

class TodoListState extends State<TodoWidget> {
  // Placeholder state entities
  List<Todo> todoItems = [
    Todo("12345", "Learn AWS Amplify...", false),
    Todo("23456", "Learn AWS AppSync...", false),
    Todo("34678", "Make Serverless GraphQL happen!", false),
  ];

  @override
  void initState() {
    super.initState();

    // Initialize Amplify service components
    Amplify.addPlugin(AmplifyAPI());
    Amplify.configure(amplifyconfig);
  }

  // Callbacks
  // Switch completion state for toggled todo item
  void onTodoToggle(Todo todo) {
    setState(() {
      todo.setCompleted(!todo.isCompleted());
    });
  }

  // Create new todo item
  void onTodoAdd(String name, bool completed) {
    setState(() {
      todoItems
          .add(Todo(randomNumber.nextInt(100000).toString(), name, completed));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: "/",
        routes: {
          '/': (context) =>
              ListTodosView(todoItems: todoItems, onTodoToggle: onTodoToggle),
          '/addtodo': (context) => AddTodoView(onTodoAdd: onTodoAdd)
        });
  }
}
