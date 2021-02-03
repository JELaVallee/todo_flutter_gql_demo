import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';
// Amplify configuration
import 'amplifyconfiguration.dart';

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
  @override
  void initState() {
    super.initState();

    // Initialize Amplify service components
    Amplify.addPlugin(AmplifyAPI());
    Amplify.configure(amplifyconfig);
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
            body: Center(child: Text('Hello Todo with GraphQL!'))));
  }
}
