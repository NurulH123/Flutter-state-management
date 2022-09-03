import 'package:flutter/material.dart';
import 'package:state_management/custom_icon/custom_icons_icons.dart';

class NoteItem extends StatefulWidget {
  final String id;
  final String title;
  final String note;
  final bool isPinned;
  final Function(String id) toggleIsPinnedFn;

  NoteItem({
    @required this.id,
    @required this.title,
    @required this.note,
    @required this.isPinned,
    @required this.toggleIsPinnedFn,
  });

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  bool _isPinned;

  @override
  Widget build(BuildContext context) {
    _isPinned = widget.isPinned;

    return GridTile(
      header: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: () {
            widget.toggleIsPinnedFn(widget.id);
          },
          icon: Icon(
            _isPinned ? CustomIcons.pin : CustomIcons.pin_outline,
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
        child: Text(widget.note),
      ),
      footer: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
        child: Container(
          height: 50,
          color: Colors.black,
          child: Center(child: Text(widget.title)),
        ),
      ),
    );
  }
}
