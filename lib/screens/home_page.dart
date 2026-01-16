import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/task.dart';
import 'add_task_page.dart';
import 'edit_task_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DBHelper dbHelper = DBHelper();
  List<Task> tasks = [];

  void loadData() async {
    final data = await dbHelper.getTasks();
    setState(() {
      tasks = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do List')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.nama),
            subtitle: Text(task.deskripsi),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditTaskPage(task),
                      ),
                    );
                    loadData();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await dbHelper.deleteTask(task.id!);
                    loadData();
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddTaskPage()),
          );
          loadData();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
