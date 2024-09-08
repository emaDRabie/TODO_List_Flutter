import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../utils/app_styles.dart';

class TodoItemWidget extends StatelessWidget {
  const TodoItemWidget({
    super.key,
    required this.todo,
    required this.onDelete,
    required this.onToggleCompleted,
    required this.onUpdate,
  });

  final Todo todo;
  final VoidCallback onDelete;
  final VoidCallback onToggleCompleted;
  final Function(Todo) onUpdate;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: ListTile(
        title: Text(
          todo.title,
          style: todo.isCompleted
              ? AppStyles.completedTodoTextStyle
              : AppStyles.todoTextStyle,
        ),
        subtitle: Text(
          todo.description,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
            letterSpacing: 0.5,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                _showEditTodoDialog(context);
              },
              icon: const Icon(
                Icons.edit,
                color: AppStyles.secondaryColor,
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 249, 229, 227),
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                onPressed: onToggleCompleted,
                color: todo.isCompleted ? Colors.green : Colors.red,
                icon: todo.isCompleted
                    ? const Icon(Icons.check_box)
                    : const Icon(Icons.indeterminate_check_box),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditTodoDialog(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: todo.title);
    TextEditingController descriptionController =
        TextEditingController(text: todo.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                todo.title = titleController.text;
                todo.description = descriptionController.text;
                onUpdate(todo);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
