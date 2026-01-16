import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/task.dart';

class AddTaskPage extends StatelessWidget {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Tugas')),
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
                final task = Task(
                  nama: namaController.text,
                  deskripsi: descController.text,
                  status: 0,
                );

                await DBHelper().insertTask(task);
                Navigator.pop(context);
              },
              child: Text('Simpan'),
            )
          ],
        ),
      ),
    );
  }
}
