import 'package:flutter/material.dart';
import '../models/note.dart';
import '../widgets/note_card.dart';

class FavoritePage extends StatefulWidget {
  final List<Note> favoriteNotes;
  final Function(Note) onFavoriteToggle;

  const FavoritePage({
    super.key,
    required this.favoriteNotes,
    required this.onFavoriteToggle,
  });

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late List<Note> localFavoriteNotes;

  @override
  void initState() {
    super.initState();
    // Menyalin daftar favorit dari data favorit di halaman utama
    localFavoriteNotes = List.from(widget.favoriteNotes);
  }

  void removeFavorite(Note note) {
    setState(() {
      localFavoriteNotes.remove(note); // Hapus catatan dari daftar lokal
      widget.onFavoriteToggle(note); // Memperbarui daftar favorit di HomePage
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text('Favorite Notes', style: TextStyle(fontSize: 24)),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              localFavoriteNotes.isEmpty
                  ? Center(
                    child: Text(
                      'No favorite notes yet!',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                  : ListView.builder(
                    itemCount: localFavoriteNotes.length,
                    itemBuilder: (context, index) {
                      return NoteCard(
                        note: localFavoriteNotes[index],
                        isFavorite: true,
                        onFavoriteToggle:
                            () => removeFavorite(localFavoriteNotes[index]),
                      );
                    },
                  ),
        ),
      ),
    );
  }
}
