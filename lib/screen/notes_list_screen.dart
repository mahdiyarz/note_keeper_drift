import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:note_keeper_drift/widgets/note_grid_tile.dart';
import 'package:provider/provider.dart';

import '../database/database.dart';
import '../widgets/add_note_button.dart';
import 'note_detail_screen.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  late MyDatabase db;
  int axisCount = 2;
  @override
  Widget build(BuildContext context) {
    db = Provider.of<MyDatabase>(context);

    return Scaffold(
      appBar: _getNoteListAppBar(),
      body: FutureBuilder<List<NoteData>>(
        future: _getNoteFromDatabase(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<NoteData> noteList = snapshot.data ?? [];
            if (noteList.isEmpty) {
              return Center(
                child: Text(
                  'No Notes Found!\nClick on add button to add new note.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            }
            return noteListUI(noteList);
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return Center(
            child: Text(
              'Click on add button to add new note.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        },
      ),
      floatingActionButton: AddNoteButton(
        onPressed: () => _navigateToDetail(
          context,
          'Add Note',
          const NoteCompanion(
            title: Value(''),
            description: Value(''),
            color: Value(1),
            priority: Value(1),
          ),
        ),
      ),
    );
  }

  Future<List<NoteData>> _getNoteFromDatabase() async {
    return await db.getNoteList();
  }

  Widget noteListUI(List<NoteData> noteList) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: axisCount == 2 ? 2 : 1,
          childAspectRatio: axisCount == 2 ? 1 : 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: noteList.length,
        itemBuilder: (context, index) => NoteGridTile(
          noteData: noteList[index],
          onTap: () => _navigateToDetail(
            context,
            'Edit Note',
            NoteCompanion(
              id: Value(noteList[index].id),
              title: Value(noteList[index].title),
              description: Value(noteList[index].description),
              color: Value(noteList[index].priority),
              priority: Value(noteList[index].color),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToDetail(
    BuildContext ctx,
    String title,
    NoteCompanion noteCompanion,
  ) async {
    var res = await Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (ctx) => NoteDetailScreen(
          title: title,
          noteCompanion: noteCompanion,
        ),
      ),
    );
    if (res != null && res == true) {
      setState(() {});
    }
  }

  _getNoteListAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      title: Text(
        'Notes',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      actions: [
        IconButton(
          onPressed: () {
            if (axisCount == 2) {
              axisCount = 1;
            } else {
              axisCount = 2;
            }
            setState(() {});
          },
          icon: Icon(
            axisCount == 1 ? Icons.grid_view_rounded : Icons.list_alt_rounded,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
