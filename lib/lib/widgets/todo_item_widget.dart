import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/todo.dart';
import '../utils/app_styles.dart';

class TodoItemWidget extends StatefulWidget {
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
  _TodoItemWidgetState createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: ExpansionPanelList.radio(
        elevation: 2,
        expandedHeaderPadding: const EdgeInsets.all(0),
        animationDuration: const Duration(milliseconds: 500),
        children: [
          ExpansionPanelRadio(
            canTapOnHeader: true,
            backgroundColor: const Color.fromARGB(255, 205, 233, 255),
            value: widget.todo.id, // Unique identifier for each panel
            headerBuilder: (context, isExpanded) {
              return ListTile(
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.todo.title,
                        style: widget.todo.isCompleted
                            ? AppStyles.completedTodoTextStyle.copyWith(
                                color: Colors.black, // Make title black
                              )
                            : AppStyles.todoTextStyle.copyWith(
                                color: Colors.black, // Make title black
                              ),
                      ),
                      const TextSpan(text: '       '), // Space between title and date
                      TextSpan(
                        text: widget.todo.date != null
                            ? DateFormat.yMMMd().format(widget.todo.date!)
                            : 'No date selected', // Handle null case
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            body: Padding(
              padding: const EdgeInsets.only(bottom: 8, right: 4),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      widget.todo.description,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 136, 136, 136),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                        onPressed: widget.onDelete,
                        icon: const Icon(Icons.delete),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 249, 229, 227),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          onPressed: widget.onToggleCompleted,
                          color: widget.todo.isCompleted ? Colors.green : Colors.red,
                          icon: widget.todo.isCompleted
                              ? const Icon(Icons.check_box)
                              : const Icon(Icons.indeterminate_check_box),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditTodoDialog(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: widget.todo.title);
    TextEditingController descriptionController =
        TextEditingController(text: widget.todo.description);

    DateTime? selectedDate = widget.todo.date; // Initialize with current date if exists

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
              const SizedBox(height: 16),
              // Add Date Picker Button
              TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
                child: Text(selectedDate != null
                    ? DateFormat.yMMMd().format(selectedDate!)
                    : 'Select Date'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                widget.todo.title = titleController.text;
                widget.todo.description = descriptionController.text;
                widget.todo.date = selectedDate;
                widget.onUpdate(widget.todo);
                Navigator.of(context).pop();
              },
              child: const Text('Save', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }
}
