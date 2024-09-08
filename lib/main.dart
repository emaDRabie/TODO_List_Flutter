import 'package:flutter/material.dart';
import 'package:to_do_list_app/controllers/todo_controller.dart';
import 'package:to_do_list_app/models/todo.dart';
import 'package:to_do_list_app/widgets/todo_item_widget.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TodoController _todoController = TodoController();
  var x = Todo(
    id: '1',
    title: 'English',
    description: 'Studying grammar',
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: const Color.fromARGB(255, 192, 1, 103),
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
                onPressed: () {},
                icon: const Icon(
                  Icons.share_arrival_time_sharp,
                  color: Colors.white,
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
              const SizedBox(height: 40),
              TodoItemWidget(
                todo: x,
                onDelete: () {
                  setState(() {
                    _todoController.removeTodo(x);
                  });
                },
                onToggleCompleted: () {
                  setState(() {
                    _todoController.toggleCompleted(x);
                  });
                },
                onUpdate: (todo) {
                  setState(() {
                    _todoController.updateTodo(todo);
                  });
                },
              ),
              const Spacer(), // This pushes the button to the bottom
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  width: 130,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 192, 1, 103)),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          // side: const BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                    onPressed: () {
                      // Button action
                    },
                    child: Text(
                      'Add Task',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: GoogleFonts.orienta().fontFamily,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 210, 235),
      ),
    );
  }
}
