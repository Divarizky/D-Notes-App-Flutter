import 'package:flutter/material.dart';
import '../models/note.dart';

class DetailNotesPage extends StatefulWidget {
  // Jika null, maka untuk menambahkan catatan baru
  final Note? note;

  const DetailNotesPage({super.key, this.note});

  @override
  State<DetailNotesPage> createState() => _DetailNotesPageState();
}

class _DetailNotesPageState extends State<DetailNotesPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan data dari note jika sedang mengedit
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(
      text: widget.note?.content ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Title and content cannot be empty')),
      );
      return;
    }

    Navigator.pop(
      context,
      Note(
        id: widget.note?.id ?? DateTime.now().millisecondsSinceEpoch,
        title: title,
        content: content,
      ),
    );
  }

  // Menghapus catatan dengan mengembalikan null
  void _deleteNote() {
    Navigator.pop(context, null);
  }

  @override
  Widget build(BuildContext context) {
    // Untuk mengecek apakah sedang mengedit atau menambah catatan baru
    final isEditing = widget.note != null;

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        foregroundColor: Colors.white,
        title: Text(isEditing ? 'Edit Note' : 'Add Note'),
        actions: [
          IconButton(
            // Menyimpan catatan saat ikon Simpan diklik
            onPressed: _saveNote,
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.save, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input Title
            TextField(
              controller: _titleController,
              style: TextStyle(fontSize: 20, color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
            SizedBox(height: 10),

            // Input Content
            Expanded(
              child: TextField(
                controller: _contentController,
                style: TextStyle(fontSize: 16, color: Colors.white),
                maxLines: null, // Tidak ada batasan jumlah baris
                decoration: InputDecoration(
                  hintText: 'Write your note here...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),

      // Floating Button Delete
      floatingActionButton: isEditing
          ? FloatingActionButton(
        onPressed: _deleteNote,
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        child: const Icon(Icons.delete, color: Colors.white, size: 38),
      )
          : null,
    );
  }
}
