import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/task.dart';

class EditTaskPage extends StatelessWidget {
  final Task task;

  EditTaskPage(this.task);

  @override
  Widget build(BuildContext context) {
    final namaController = TextEditingController(text: task.nama);
    final descController = TextEditingController(text: task.deskripsi);

    return Scaffold(
      appBar: AppBar(title: Text('Edit Tugas')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama Tugas'),
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final updatedTask = Task(
                  id: task.id,
                  nama: namaController.text,
                  deskripsi: descController.text,
                  status: task.status,
                );

                await DBHelper().updateTask(updatedTask);
                Navigator.pop(context);
              },
              child: Text('Update'),
            )
          ],
        ),
      ),
    );
  }
}
