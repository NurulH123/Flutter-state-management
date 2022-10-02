import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:state_management/models/notes.dart';

class NoteApi {
  // https://notes-a7434-default-rtdb.asia-southeast1.firebasedatabase.app/

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
}
