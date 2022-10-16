import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:state_management/models/notes.dart';

class NoteApi {
  // https://notes-a7434-default-rtdb.asia-southeast1.firebasedatabase.app/notes.json

  Future<List<Note>> getAllNote() async {
    final uri = Uri.parse(
        'https://notes-a7434-default-rtdb.asia-southeast1.firebasedatabase.app/notes.json');
    final response = await http.get(uri);

    final results = json.decode(response.body) as Map<String, dynamic>;
    List<Note> notes = [];

    results.forEach((key, value) {
      notes.add(Note(
          id: key,
          title: value['title'],
          note: value['note'],
          isPinned: value['isPinned'],
          updatedAt: DateTime.parse(value['updated_at']),
          createdAt: DateTime.parse(value['created_at'])));
    });

    return notes;
  }

  Future<String> postNote(Note note) async {
    final uri = Uri.parse(
        'https://notes-a7434-default-rtdb.asia-southeast1.firebasedatabase.app/notes.json');

    Map<String, dynamic> map = {
      'title': note.title,
      'note': note.note,
      'isPinned': note.isPinned,
      'updated_at': note.updatedAt.toIso8601String(),
      'created_at': note.createdAt.toIso8601String(),
    };

    final body = json.encode(map);
    final results = await http.post(uri, body: body);

    return json.decode(results.body)['name'];
  }

  void updateNote(Note newNote) async {
    final uri = Uri.parse(
        'https://notes-a7434-default-rtdb.asia-southeast1.firebasedatabase.app/notes/${newNote.id}.json');

    Map<String, dynamic> map = {
      'title': newNote.title,
      'note': newNote.note,
      'updated_at': newNote.updatedAt.toIso8601String(),
    };

    final body = json.encode(map);
    final results = await http.patch(uri, body: body);
  }

  Future<void> toggleIsPinned(
      String id, bool isPinned, DateTime updatedAt) async {
    final uri = Uri.parse(
        'https://notes-a7434-default-rtdb.asia-southeast1.firebasedatabase.app/notes/$id.json');

    Map<String, dynamic> map = {
      'isPinned': isPinned,
      'updated_at': updatedAt.toIso8601String(),
    };

    final body = json.encode(map);
    final results = await http.patch(uri, body: body);
  }

  void deleteNote(String id) {
    final uri = Uri.parse(
        'https://notes-a7434-default-rtdb.asia-southeast1.firebasedatabase.app/notes/$id.json');

    final results = http.delete(uri);
  }
}
