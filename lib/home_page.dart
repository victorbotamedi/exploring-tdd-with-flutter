import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd/cubit/notes_cubit.dart';
import 'package:flutter_tdd/cubit/states.dart';
import 'package:flutter_tdd/note_page.dart';

class HomePage extends StatelessWidget {
  final NotesCubit notesCubit;
  final String title;

  HomePage({Key key, this.title, this.notesCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: BlocBuilder<NotesCubit, NotesState>(
          cubit: notesCubit,
          builder: (context, state) => ListView.builder(
            itemCount: state.notes.length,
            itemBuilder: (context, index) {
              var note = state.notes[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.body),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToNotePage(context),
          tooltip: 'Add',
          child: Icon(Icons.add),
        ),
      );

  _navigateToNotePage(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotePage(
            notesCubit: notesCubit,
          ),
        ),
      );
}
