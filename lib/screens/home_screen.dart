import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/providers/notes.dart';
import '../widgets/notes_grid.dart';
import 'add_or_detail_screeen.dart';
import '../models/notes.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: FutureBuilder(
        future: Provider.of<Notes>(context, listen: false).getAndSetNotes(),
        builder: (ctx, notesSnapshot) {
          if (notesSnapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator(),);

          return NotesGrid();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddOrDetailScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
