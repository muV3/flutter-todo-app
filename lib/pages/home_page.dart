import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/util/app_colors.dart';
import 'package:todo_app/util/dialog_box.dart';
import 'package:todo_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference to the Hive box
  final _myBox = Hive.box('todoBox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // if this is the first time the app is opened, create initial data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there is already data in the box, load it
      db.loadData();
    }
    super.initState();
  }

  // Controller for the text field in the dialog box
  final TextEditingController _controller = TextEditingController();

  // Function to handle checkbox changes
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.tasks[index][1] = value;
    });
    db.updateDatabase();
  }

  void addNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.tasks.removeAt(index);
    });
    db.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      db.tasks.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'TO DO',
          style: GoogleFonts.merriweather(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),

      // Button to add new task
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: addNewTask,
          backgroundColor: AppColors.primary,
          elevation: 1,
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),

      body: ListView.builder(
        itemCount: db.tasks.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.tasks[index][0],
            isCompleted: db.tasks[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
