import 'package:flutter/material.dart';
import 'package:flutter_tdd/cubit/notes_cubit.dart';
import 'package:flutter_tdd/home_page.dart';
import 'package:flutter_tdd/note_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Home Page', () {
    _pumpTestWidget(WidgetTester tester, NotesCubit cubit) => tester.pumpWidget(
          MaterialApp(
            home: HomePage(
              title: 'Home',
              notesCubit: cubit,
            ),
          ),
        );

    testWidgets('empty state', (WidgetTester tester) async {
      await _pumpTestWidget(tester, NotesCubit());
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsNothing);
    });

    testWidgets('updates list when a note is added',
        (WidgetTester tester) async {
      var notesCubit = NotesCubit();
      await _pumpTestWidget(tester, notesCubit);
      var expectedTitle = 'note title';
      var expectedBody = 'note body';
      notesCubit.createNote(expectedTitle, expectedBody);
      notesCubit.createNote('another note', 'another note body');
      await tester.pump();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(2));
      expect(find.text(expectedTitle), findsOneWidget);
      expect(find.text(expectedBody), findsOneWidget);
    });

    testWidgets('updates list when a note is deleted',
        (WidgetTester tester) async {
      var notesCubit = NotesCubit();
      await _pumpTestWidget(tester, notesCubit);
      var expectedTitle = 'note title';
      var expectedBody = 'note body';
      notesCubit.createNote(expectedTitle, expectedBody);
      notesCubit.createNote('another note', 'another note body');
      await tester.pump();

      notesCubit.deleteNote(1);
      await tester.pumpAndSettle();
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
      expect(find.text(expectedTitle), findsNothing);
    });

    testWidgets('navigate to note page', (WidgetTester tester) async {
      var notesCubit = NotesCubit();
      await _pumpTestWidget(tester, notesCubit);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(NotePage), findsOneWidget);
    });

    testWidgets('navigate to note page in edit mode',
        (WidgetTester tester) async {
      var notesCubit = NotesCubit();
      await _pumpTestWidget(tester, notesCubit);
      var expectedTitle = 'note title';
      var expectedBody = 'note body';
      notesCubit.createNote(expectedTitle, expectedBody);
      await tester.pump();
      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();
      expect(find.byType(NotePage), findsOneWidget);
      expect(find.text(expectedTitle), findsOneWidget);
      expect(find.text(expectedBody), findsOneWidget);
    });
  });
}
