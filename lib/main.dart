import 'dart:convert';

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
  // Amplify service
  final _amplify = Amplify;
  bool _amplifyConfigured = false;

  // Placeholder state entities
  List<Todo> todoItems = [];

  @override
  void initState() {
    super.initState();

    // Initialize Amplify service components
    _configureAmplify();
  }

  void _configureAmplify() async {
    _amplify.addPlugin(AmplifyAPI());
    try {
      await _amplify.configure(amplifyconfig);
      print('Successfully configured Amplify!!!');
      doLoadTodoList();
    } catch (e) {
      print('Could not configure Amplify...');
    }
  }

  // Callbacks
  // Switch completion state for toggled todo item
  void onTodoToggle(Todo todo) {
    updateTodoItem(todo);
  }

  // Create new todo item
  void onTodoAdd(String name) {
    addTodoItem(Todo("1111", name, false));
  }

  // Service Handlers
  void doLoadTodoList() async {
    try {
      String gqlQuery = '''query{
        listTodos {
          items {
            id
            name
            completed
          }
        }
      }''';

      var operation = Amplify.API
          .query(request: GraphQLRequest<String>(document: gqlQuery));

      var response = await operation.response;
      var data = response.data;
      Map<String, dynamic> listTodos = jsonDecode(data);
      List<dynamic> todoResponseItems = listTodos['listTodos']['items'];
      List<Todo> todoItemsList = [];
      todoResponseItems.forEach((item) {
        print('Loaded Item: ' + item.toString());
        todoItemsList.add(Todo(item['id'], item['name'], item['completed']));
      });
      setState(() {
        todoItems = todoItemsList;
      });
    } catch (e) {
      print(e);
    }
  }

  void addTodoItem(Todo todo) async {
    try {
      String gqlMutation =
          '''mutation CreateTodo(\$name: String!, \$completed: Boolean!){
        createTodo(input: {name: \$name, completed: \$completed}){
          id
          name
          completed
        }
      }''';

      var gqlRequest =
          GraphQLRequest<String>(document: gqlMutation, variables: {
        "name": todo.getName(),
        "completed": todo.isCompleted(),
      });

      var operation = Amplify.API.mutate(request: gqlRequest);
      var response = await operation.response;
      var data = response.data;

      print('Mutation result: ' + data);
      doLoadTodoList();
    } catch (e) {
      print(e);
    }
  }

  void updateTodoItem(Todo todo) async {
    try {
      String gqlMutation =
          '''mutation UpdateTodo(\$id: ID!, \$completed: Boolean){
        updateTodo(input: {id: \$id, completed: \$completed}){
          id
          name
          completed
        }
      }''';

      var gqlRequest =
          GraphQLRequest<String>(document: gqlMutation, variables: {
        "id": todo.getId(),
        "completed": !todo.isCompleted(),
      });

      var operation = Amplify.API.mutate(request: gqlRequest);
      var response = await operation.response;
      var data = response.data;

      print('Mutation result: ' + data);
      doLoadTodoList();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: "/",
        routes: {
          '/': (context) => ListTodosView(
              todoItems: todoItems,
              onTodoToggle: onTodoToggle,
              reloadTodoList: doLoadTodoList),
          '/addtodo': (context) => AddTodoView(onTodoAdd: onTodoAdd)
        });
  }
}
