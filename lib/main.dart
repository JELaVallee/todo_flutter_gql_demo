import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';
// Amplify configuration
import 'amplifyconfiguration.dart';

// Models
import './model/todo.dart';

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
  void onTodoToggle(Todo todo) {
    setState(() {
      todo.setCompleted(!todo.isCompleted());
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
        home: Scaffold(
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
                })));
  }
}
