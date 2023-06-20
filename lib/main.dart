import 'package:flutter/material.dart';
import 'package:note_keeper_drift/database/database.dart';
import 'package:provider/provider.dart';

import 'screen/notes_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => MyDatabase(),
      child: MaterialApp(
        title: 'Note Keeper',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NotesListScreen(),
      ),
    );
  }
}
