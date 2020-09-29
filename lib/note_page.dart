import 'package:flutter/material.dart';
import 'package:flutter_tdd/cubit/notes_cubit.dart';

class NotePage extends StatefulWidget {
  final NotesCubit notesCubit;

  const NotePage({Key key, this.notesCubit}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
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
    widget.notesCubit.createNote(_titleController.text, _bodyController.text);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _bodyController.dispose();
  }
}
