class ToDo {
  final String id;
  final String toDoText;
  bool isDone;
  ToDo({required this.id, required this.toDoText, this.isDone = false});

  static List<ToDo> todoList() {
    return [
      ToDo(id: "01", toDoText: "Go for shopping", isDone: false),
    ];
  }
}
