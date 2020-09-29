import 'package:flutter/material.dart';
import 'package:flutter_tdd/cubit/notes_cubit.dart';
import 'package:flutter_tdd/model/note.dart';

class NotePage extends StatefulWidget {
  final NotesCubit notesCubit;
  final Note note;

  const NotePage({Key key, this.notesCubit, this.note}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note == null) return;
    _titleController.text = widget.note.title;
    _bodyController.text = widget.note.body;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: widget.note != null ? _deleteNote : null,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                key: ValueKey('title'),
                controller: _titleController,
                autofocus: true,
                decoration: InputDecoration(hintText: 'Title'),
              ),
              Expanded(
                child: TextField(
                  key: ValueKey('body'),
                  controller: _bodyController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 500,
                  decoration:
                      InputDecoration(hintText: 'Enter your text here...'),
                ),
              ),
              RaisedButton(
                child: Text('Ok'),
                onPressed: () => _finishEditing(),
              )
            ],
          ),
        ),
      );

  _finishEditing() {
    if (widget.note != null) {
      widget.notesCubit.updateNote(
          widget.note.id, _titleController.text, _bodyController.text);
    } else {
      widget.notesCubit.createNote(_titleController.text, _bodyController.text);
    }
    Navigator.pop(context);
  }

  _deleteNote() {
    widget.notesCubit.deleteNote(widget.note.id);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _bodyController.dispose();
  }
}
