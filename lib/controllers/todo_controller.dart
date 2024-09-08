import '../models/todo.dart';

class TodoController {
  List<Todo> todos = [];

  void addTodo(Todo todo) {
    todos.add(todo);
  }

  void removeTodo(Todo todo) {
    todos.removeWhere((t) => t.id == todo.id);
  }

  void toggleCompleted(Todo todo) {
    todo.isCompleted = !todo.isCompleted;
  }

  void updateTodo(Todo todo) {
    int index = todos.indexWhere((element) => element.id == todo.id);
    if (index != -1) {
      todos[index] = todo;
    }
  }
}
