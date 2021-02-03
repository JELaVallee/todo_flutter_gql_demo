import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';
// Amplify configuration
import 'amplifyconfiguration.dart';

// Models
import './model/todo.dart';

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
  // Placeholder state entity
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
  void onTodoAdd(String id, String name, bool completed) {
    setState(() {
      todoItems.add(Todo(id, name, completed));
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

class ListTodosView extends StatelessWidget {
  final List<Todo> todoItems;
  final onTodoToggle;

  ListTodosView({@required this.todoItems, @required this.onTodoToggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
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

class AddTodoView extends StatefulWidget {
  final onTodoAdd;

  AddTodoView({@required this.onTodoAdd});

  @override
  State<StatefulWidget> createState() {
    return AddTodoState();
  }
}

class AddTodoState extends State<AddTodoView> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Todo Item')),
      body: Center(
          child: Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                  autofocus: true,
                  controller: textController,
                  decoration: InputDecoration(
                      labelText: 'Enter your new todo item...')))),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          widget.onTodoAdd(randomNumber.nextInt(100000).toString(),
              textController.text, false);
          Navigator.pop(context);
        },
      ),
    );
  }
}
