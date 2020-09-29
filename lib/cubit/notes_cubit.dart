import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Note extends Equatable {
  final int id;
  final String title;
  final String body;

  Note(this.id, this.title, this.body);

  @override
  List<Object> get props => [id, title, body];
}

class NotesState {
  final UnmodifiableListView<Note> notes;
  NotesState(this.notes);
}

class NotesCubit extends Cubit<NotesState> {
  List<Note> _notes = [];
  int autoIncrementId = 0;

  NotesCubit() : super(NotesState(UnmodifiableListView([])));

  void createNote(String title, String body) {
    _notes.add(Note(++autoIncrementId, title, body));
    emit(NotesState(UnmodifiableListView(_notes)));
  }

  void deleteNote(int id) {
    _notes = _notes.where((element) => element.id != id).toList();
    emit(NotesState(UnmodifiableListView(_notes)));
  }

  void updateNote(int id, String title, String body) {
    var noteIndex = _notes.indexWhere((element) => element.id == id);
    _notes.replaceRange(noteIndex, noteIndex + 1, [Note(id, title, body)]);
    emit(NotesState(UnmodifiableListView(_notes)));
  }
}
