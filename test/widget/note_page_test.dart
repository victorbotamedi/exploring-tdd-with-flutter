import 'package:flutter/material.dart';
import 'package:flutter_tdd/cubit/notes_cubit.dart';
import 'package:flutter_tdd/model/note.dart';
import 'package:flutter_tdd/note_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Note Page', () {
    _pumpTestWidget(WidgetTester tester, NotesCubit cubit, {Note note}) =>
        tester.pumpWidget(
          MaterialApp(
            home: NotePage(
              notesCubit: cubit,
              note: note,
            ),
          ),
        );

    testWidgets('empty state', (WidgetTester tester) async {
      await _pumpTestWidget(tester, NotesCubit());
      expect(find.text('Enter your text here...'), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('create note', (WidgetTester tester) async {
      var cubit = NotesCubit();
      await _pumpTestWidget(tester, cubit);
      await tester.enterText(find.byKey(ValueKey('title')), 'hi');
      await tester.enterText(find.byKey(ValueKey('body')), 'there');
      await tester.tap(find.byType(RaisedButton));
      await tester.pumpAndSettle();
      expect(cubit.state.notes, isNotEmpty);
      var note = cubit.state.notes.first;
      expect(note.title, 'hi');
      expect(note.body, 'there');
      expect(find.byType(NotePage), findsNothing);
    });

    testWidgets('create in edit mode', (WidgetTester tester) async {
      var note = Note(1, 'my note', 'note body');
      await _pumpTestWidget(tester, NotesCubit(), note: note);
      expect(find.text(note.title), findsOneWidget);
      expect(find.text(note.body), findsOneWidget);
    });

    testWidgets('edit note', (WidgetTester tester) async {
      var cubit = NotesCubit()..createNote('my note', 'note body');
      await _pumpTestWidget(tester, cubit, note: cubit.state.notes.first);
      await tester.enterText(find.byKey(ValueKey('title')), 'hi');
      await tester.enterText(find.byKey(ValueKey('body')), 'there');
      await tester.tap(find.byType(RaisedButton));
      await tester.pumpAndSettle();
      expect(cubit.state.notes, isNotEmpty);
      var note = cubit.state.notes.first;
      expect(note.title, 'hi');
      expect(note.body, 'there');
      expect(find.byType(NotePage), findsNothing);
    });
  });
}
