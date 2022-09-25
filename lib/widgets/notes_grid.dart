import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/models/notes.dart';
import '../providers/notes.dart';
import './note_item.dart';

class NotesGrid extends StatefulWidget {
  @override
  State<NotesGrid> createState() => _NotesGridState();
}

class _NotesGridState extends State<NotesGrid> {
  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<Notes>(context);
    List<Note> listNote = notesProvider.notes;

    return GridView.builder(
      itemCount: listNote.length,
      itemBuilder: (context, index) => NoteItem(
        id: listNote[index].id,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
    );
  }
}
