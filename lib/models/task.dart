class Task {
  int? id;
  String nama;
  String deskripsi;
  int status;

  Task({
    this.id,
    required this.nama,
    required this.deskripsi,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'deskripsi': deskripsi,
      'status': status,
    };
  }
}
