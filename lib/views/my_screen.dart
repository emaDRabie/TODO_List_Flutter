import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../controllers/todo_controller.dart';
import '../widgets/todo_item_widget.dart';
import '../widgets/add_todo_bottom_sheet.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TodoController _todoController = TodoController();
  var coloR = const Color.fromARGB(255, 192, 1, 103);
  var colorBlue = Colors.blue;
  var darkColor = Colors.black;
  var bckColor = const Color.fromARGB(255, 255, 210, 235);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: coloR,
        title: Center(
          child: Text(
            'ToDo List App',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 30,
              fontFamily: GoogleFonts.orienta().fontFamily,
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 59),
            child: IconButton(
              onPressed: () {
                if (Colors.blue == coloR &&
                    bckColor == const Color.fromARGB(255, 0, 0, 0)) {
                  coloR = const Color.fromARGB(255, 192, 1, 103);
                  bckColor = const Color.fromARGB(255, 255, 210, 235);
                } else {
                  coloR = colorBlue;
                  bckColor = const Color.fromARGB(255, 0, 0, 0);
                }
                setState(() {});
              },
              icon: const Icon(
                Icons.color_lens,
                color: Color.fromARGB(255, 255, 255, 255),
                size: 30,
              ),
            ),
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(70),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Today',
                    style: TextStyle(
                      color: Color.fromARGB(255, 62, 59, 59),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${DateFormat.EEEE().format(DateTime.now())}, ${DateTime.now().day}, ${DateFormat.MMM().format(DateTime.now())} ${DateTime.now().year}',
                        style: TextStyle(color: coloR, fontSize: 25),
                      ),
                      const SizedBox(width: 23),
                      Icon(
                        Icons.calendar_today,
                        color: coloR,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _todoController.todos.length,
                itemBuilder: (context, index) {
                  final todo = _todoController.todos[index];
                  return TodoItemWidget(
                    todo: todo,
                    onDelete: () {
                      setState(() {
                        _todoController.removeTodo(todo);
                      });
                    },
                    onToggleCompleted: () {
                      setState(() {
                        _todoController.toggleCompleted(todo);
                      });
                    },
                    onUpdate: (updatedTodo) {
                      setState(() {
                        _todoController.updateTodo(updatedTodo);
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: bckColor,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: coloR,
        foregroundColor: Colors.white,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: AddTodoBottomSheet(
                onAdd: (newTodo) {
                  setState(() {
                    _todoController.addTodo(newTodo);
                  });
                },
              ),
            ),
            isScrollControlled: true,
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
