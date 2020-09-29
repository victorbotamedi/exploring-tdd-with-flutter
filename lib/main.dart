import 'package:flutter/material.dart';
import 'package:flutter_tdd/home_page.dart';

import 'cubit/notes_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(
        title: 'Notes',
        notesCubit: NotesCubit(),
      ),
    );
  }
}
