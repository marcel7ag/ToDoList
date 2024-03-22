import 'package:flutter/material.dart';
import 'todo_item.dart';
import 'todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter To-Do List'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> filteredItems = [];
  @override
  void initState() {
    super.initState();
    filteredItems = todosList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary
        backgroundColor: Colors.orangeAccent,
        title: Text(widget.title),
      ),
        drawer: Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // This sets the corners to be square
          ),
          child: ListView(
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                  ),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Create new To-Do'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewListScreen(onAddToDo: (todo) => setState(() => todosList.add(todo)))),
                    ).then((_) {
                      Navigator.pop(context);
                    });
                  },
                ),
                ListTile(
                  title: Text('View all Lists'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage(title: 'Flutter To-Do List',))
                    );
                  },
                ),
              ],
          ),
        ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30)
              ),
              child: TextField(
                controller: _todoController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  labelText: "search todo",
                ),
                onChanged: (value) {
                  _filterItems(value);
                }
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                  margin: EdgeInsets.only(top: 50, bottom: 20),
                  child:
                    Text('All ToDos', style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ),
              for (ToDo todoo in filteredItems)
                ToDoItem(todo: todoo,
                onToDoChanged: _handleToDoChange,
                onDeleteItem: _deleteToDoItem,
                ),
            ],
            ),
          )
          ],
        ),
      ),
    );
  }
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }
  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }
  void _deleteToDoItem(int id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }
  void _filterItems(String value) {
    setState(() {
      if (value.isEmpty) {
        filteredItems = todosList; // Reset to the original list if the search is empty
      } else {
        filteredItems = todosList.where((todo) =>
            todo.todoText!.toLowerCase().startsWith(value.toLowerCase())).toList();
      }
    });
  }
}

class NewListScreen extends StatefulWidget {
  final Function(ToDo) onAddToDo;

  NewListScreen({required this.onAddToDo});

  @override
  _NewListScreenState createState() => _NewListScreenState();
}

List<String> options = ["ToDo ist erledigt", "ToDo ist nicht erledigt"];

class _NewListScreenState extends State<NewListScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedOption = '';
  String _listTitle = '';
  String _listDescription = '';

  final _newTodoController = TextEditingController();
  final todosList = ToDo.todoList();
  String currentOption = options[0];
  bool option = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Colors.orangeAccent,
        title: Text('Add new ToDo'),
      ),
      body: Material(
        color: Colors.white70,
      child: Center(
        child: Container(
          width: 300, // Set a fixed width for the Container
          margin: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // Center the children vertically
            children: <Widget>[
              SizedBox(
                width: 400,
                child: TextField(
                  controller: _newTodoController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Titel des ToDo's",
                  ),
                ),
              ),
              RadioListTile(
                  title: const Text('ToDo ist erledigt'),
                  value: options[0],
                  groupValue: currentOption,
                  onChanged: (value) {
                    setState(() {
                      currentOption = value.toString();
                      option = true;
                    });
                  }
              ),
              RadioListTile(
                  title: const Text('ToDo ist nicht erledigt'),
                  value: options[1],
                  groupValue: currentOption,
                  onChanged: (value) {
                    setState(() {
                      currentOption = value.toString();
                      option = false;
                    });
                  }
              ),
              ElevatedButton(
                child: Text('ToDo hinzufügen', style: TextStyle(fontSize: 16, color: Colors.white),),
                onPressed: () {
                  // print("todo added");
                  String newTodoTitle = _newTodoController.text;
                  int? latestId = todosList.isNotEmpty ? todosList.last.id : 0;
                  int newTodoId = latestId! + 1;
                  ToDo newTodo = ToDo(id: newTodoId, todoText: newTodoTitle, isDone: option,);
                  widget.onAddToDo(newTodo);
                  Navigator.pop(context);
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(60, 60),
                  elevation: 10,
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }
  void _deleteToDoItem(int id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }
}