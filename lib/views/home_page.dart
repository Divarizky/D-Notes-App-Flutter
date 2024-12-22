import 'package:flutter/material.dart';
import '../models/note.dart';
import '../widgets/note_card.dart';
import '../views/detail_notes_page.dart';
import '../views/favorite_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Inisialisasi filter searchbar dan daftar favorit
  List<Note> filteredNotes = List.from(dummyNotes);
  List<Note> favoriteNotes = [];

  // Fungsi untuk pencarian search bar
  void onSearchChanged(String searchText) {
    setState(() {
      filteredNotes =
          dummyNotes
              .where(
                (note) =>
                    note.title.toLowerCase().contains(
                      searchText.toLowerCase(),
                    ) ||
                    note.content.toLowerCase().contains(
                      searchText.toLowerCase(),
                    ),
              )
              .toList();
    });
  }

  // Fungsi untuk menandai atau menghapus favorit
  void toggleFavorite(Note note) {
    setState(() {
      if (favoriteNotes.contains(note)) {
        favoriteNotes.remove(note);
      } else {
        favoriteNotes.add(note);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        foregroundColor: Colors.white,
        title: Text('My Notes', style: TextStyle(fontSize: 24)),
        actions: [
          // Tombol untuk halaman Favorite
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => FavoritePage(
                        favoriteNotes: favoriteNotes,
                        onFavoriteToggle: toggleFavorite,
                      ),
                ),
              );
            },
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.favorite, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Search Bar Section
              TextField(
                onChanged: onSearchChanged,
                style: TextStyle(fontSize: 16, color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                  hintText: 'Search notes',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  fillColor: Colors.grey.shade800,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // List Notes Section
              Expanded(
                child: ListView.builder(
                  itemCount: filteredNotes.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        final updatedNote = await Navigator.push<Note>(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    DetailNotesPage(note: filteredNotes[index]),
                          ),
                        );

                        if (updatedNote != null) {
                          setState(() {
                            int oldNotes = dummyNotes.indexOf(
                              filteredNotes[index],
                            );
                            dummyNotes[oldNotes] = updatedNote;
                            filteredNotes[index] = updatedNote;
                          });
                        }
                      },
                      child: NoteCard(
                        note: filteredNotes[index],
                        isFavorite: favoriteNotes.contains(
                          filteredNotes[index],
                        ),
                        onFavoriteToggle:
                            () => toggleFavorite(filteredNotes[index]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newNote = await Navigator.push<Note>(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const DetailNotesPage(),
            ),
          );
          if (newNote != null) {
            setState(() {
              dummyNotes.add(newNote);
              filteredNotes.add(newNote);
            });
          }
        },
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        child: const Icon(Icons.add, color: Colors.white, size: 38),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
