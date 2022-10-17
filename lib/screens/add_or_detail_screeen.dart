import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:state_management/models/notes.dart';
import 'package:state_management/providers/notes.dart';

class AddOrDetailScreen extends StatefulWidget {
  static const routeName = '/AddOrDetailScreen';
  @override
  State<AddOrDetailScreen> createState() => _AddOrDetailScreenState();
}

class _AddOrDetailScreenState extends State<AddOrDetailScreen> {
  Note _note =
      Note(id: null, title: '', note: '', updatedAt: null, createdAt: null);

  bool _init = true;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  void _submitNote() async {
    _formKey.currentState.save();
    final now = DateTime.now();
    _note = _note.copyWith(updatedAt: now, createdAt: now);
    final notesProvider = Provider.of<Notes>(context, listen: false);
    setState(() {
      _isLoading = true;
    });
    // Jika id notenya null maka dia akan menambahkan note,
    // namun jika tdk null maka dia akan mengupdate note
    if (_note.id == null) {
      await notesProvider.addNote(_note);
    } else {
      await notesProvider.updateNotes(_note);
    }
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      String id = ModalRoute.of(context).settings.arguments as String;
      if (id != null) {
        _note = Provider.of<Notes>(context).getNote(id);
      }
      _init = false;
    }
    super.didChangeDependencies();
  }

  String _convertDate(DateTime dateTime) {
    int diff = DateTime.now().difference(dateTime).inDays;

    if (diff > 0) {
      return DateFormat('dd-MM-yyyy').format(dateTime);
    }

    return DateFormat('HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: _submitNote,
            child: _isLoading
                ? CircularProgressIndicator()
                : Text('Simpan',
                    style: TextStyle(
                      color: Colors.white,
                    )),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            padding: EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _note.title,
                      decoration: InputDecoration(
                        hintText: 'Judul',
                        border: InputBorder.none,
                      ),
                      onSaved: (value) {
                        _note = _note.copyWith(title: value);
                      },
                    ),
                    TextFormField(
                      initialValue: _note.note,
                      decoration: InputDecoration(
                        hintText: 'Tulis catatan disini...',
                        border: InputBorder.none,
                      ),
                      onSaved: (value) {
                        _note = _note.copyWith(note: value);
                      },
                      maxLines: null,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_note.updatedAt != null)
            Positioned(
              bottom: 10,
              right: 10,
              child: Text('Terakhir diubah ${_convertDate(_note.updatedAt)}'),
            ),
        ],
      ),
    );
  }
}
