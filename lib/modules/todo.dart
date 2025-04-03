
class Todo {
  String? id;
  String? toDoText;
  bool isDone;

  Todo({
    this.id,
    this.toDoText,
    this.isDone = false, // Initializes isDone to false by default
  });

  static List<Todo> get todolist {
    return [];
  }
}
