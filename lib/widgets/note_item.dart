import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/custom_icon/custom_icons_icons.dart';
import 'package:state_management/models/notes.dart';
import 'package:state_management/screens/add_or_detail_screeen.dart';
import '../providers/notes.dart';

class NoteItem extends StatefulWidget {
  final String id;
  final BuildContext ctx;

  NoteItem({
    @required this.id,
    @required this.ctx,
  });

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<Notes>(context, listen: false);
    Note note = notesProvider.getNote(widget.id);

    return Dismissible(
      key: Key(note.id),
      onDismissed: (direction) {
        ScaffoldMessenger.of(widget.ctx).clearSnackBars();
        notesProvider.deleteNote(note.id).catchError((onError) {
          ScaffoldMessenger.of(widget.ctx)
              .showSnackBar(SnackBar(content: Text(onError.toString())));
        });
      },
      child: GestureDetector(
        onTap: () => {
          Navigator.of(context).pushNamed(
            AddOrDetailScreen.routeName,
            arguments: note.id,
          )
        },
        child: GridTile(
          header: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                ScaffoldMessenger.of(widget.ctx).clearSnackBars();
                notesProvider.toggleIsPinned(note.id).catchError((onError) {
                  ScaffoldMessenger.of(widget.ctx).showSnackBar(
                      SnackBar(content: Text(onError.toString())));
                });
              },
              icon: Icon(
                note.isPinned ? CustomIcons.pin : CustomIcons.pin_outline,
              ),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              border: Border.all(),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(8),
            child: Text(note.note),
          ),
          footer: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)),
            child: Container(
              height: 50,
              color: Colors.black,
              child: Center(child: Text(note.title)),
            ),
          ),
        ),
      ),
    );
  }
}
