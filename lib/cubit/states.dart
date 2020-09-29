import 'dart:collection';

import 'package:flutter_tdd/model/note.dart';

class NotesState {
  final UnmodifiableListView<Note> notes;
  NotesState(this.notes);
}
