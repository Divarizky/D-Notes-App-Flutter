class Note {
  final int id;
  final String title;
  final String content;

  Note({required this.id, required this.title, required this.content});

  // Dummy data untuk notes
  static List<Note> dummyNotes() {
    return [
      Note(
        id: 1,
        title: "HTML & CSS",
        content:
            "HTML (Hypertext Markup Language): is a markup language designed to create web pages, that is, stub",
      ),
      Note(
        id: 2,
        title: "Flutter",
        content:
            "Beautiful and expressive UI: Delight your users with beautiful built-in Material Design and Cupertino",
      ),
    ];
  }
}
