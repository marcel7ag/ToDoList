class ToDo {
  int? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false
});

  static List<ToDo> todoList() {
    return  [
      ToDo(id: 01, todoText: 'toDo nr 1', isDone: true),
      ToDo(id: 02, todoText: 'toDo nr 2', isDone: true),
      ToDo(id: 03, todoText: 'toDo nr 3'),
      ToDo(id: 04, todoText: 'toDo nr 4'),
      ToDo(id: 05, todoText: 'toDo nr 5'),
      ToDo(id: 06, todoText: 'toDo nr 6'),
    ];
  }
}