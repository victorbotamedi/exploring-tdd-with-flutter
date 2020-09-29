import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd/cubit/states.dart';
import 'package:flutter_tdd/model/note.dart';

class NotesCubit extends Cubit<NotesState> {
  List<Note> _notes = [];
  int autoIncrementId = 0;

  NotesCubit() : super(NotesState(UnmodifiableListView([])));

  void createNote(String title, String body) {
    _notes.add(Note(++autoIncrementId, title, body));
    _emit();
  }

  void deleteNote(int id) {
    _notes = _notes.where((element) => element.id != id).toList();
    _emit();
  }

  void updateNote(int id, String title, String body) {
    var noteIndex = _notes.indexWhere((element) => element.id == id);
    _notes.replaceRange(noteIndex, noteIndex + 1, [Note(id, title, body)]);
    _emit();
  }

  _emit() => emit(NotesState(UnmodifiableListView(_notes)));
}
