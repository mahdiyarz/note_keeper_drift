import 'dart:developer';

import 'package:drift/drift.dart' as dr;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/database.dart';
import '../widgets/colors_picker.dart';
import '../widgets/priority_picker.dart';

class NoteDetailScreen extends StatefulWidget {
  final String title;
  final NoteCompanion noteCompanion;
  const NoteDetailScreen(
      {required this.title, required this.noteCompanion, super.key});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late MyDatabase db;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int priorityLevel = 0;
  int colorLevel = 0;

  @override
  void dispose() {
    _titleController;
    _descriptionController;
    super.dispose();
  }

  @override
  void initState() {
    _titleController.text = widget.noteCompanion.title.value;
    _descriptionController.text = widget.noteCompanion.description.value;
    priorityLevel = widget.noteCompanion.priority.value;
    colorLevel = widget.noteCompanion.color.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    db = Provider.of<MyDatabase>(context);

    return Scaffold(
      backgroundColor: colors[colorLevel],
      appBar: _getDetailAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        width: double.infinity,
        child: Column(
          children: [
            PriorityPicker(
              index: priorityLevel,
              onTap: (selectedIndex) {
                log(selectedIndex.toString());
                priorityLevel = selectedIndex;
                setState(() {});
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ColorsPicker(
              index: colorLevel,
              onTap: (selectedColor) {
                log(selectedColor.toString());
                colorLevel = selectedColor;
                setState(() {});
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Enter Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _descriptionController,
              maxLength: 255,
              maxLines: 8,
              minLines: 7,
              decoration: InputDecoration(
                hintText: 'Enter Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getDetailAppBar() {
    return AppBar(
      backgroundColor: colors[colorLevel],
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(
          Icons.chevron_left_rounded,
          color: Colors.black,
        ),
      ),
      title: Text(
        widget.title,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            _saveToDb();
          },
          icon: const Icon(
            Icons.save_rounded,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {
            _deleteNote();
          },
          icon: const Icon(
            Icons.delete_rounded,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  void _saveToDb() {
    if (widget.noteCompanion.id.present) {
      log('pressed save editing');
      db
          .updateNote(
            NoteData(
                id: widget.noteCompanion.id.value,
                title: _titleController.text,
                description: _descriptionController.text,
                priority: priorityLevel,
                color: colorLevel),
          )
          .then(
            (value) => Navigator.pop(context, true),
          );
    } else {
      log('pressed save new note');
      db
          .insertNote(
            NoteCompanion(
              title: dr.Value(_titleController.text),
              description: dr.Value(_descriptionController.text),
              color: dr.Value(priorityLevel),
              priority: dr.Value(colorLevel),
            ),
          )
          .then(
            (value) => Navigator.pop(context, true),
          );
    }
  }

  void _deleteNote() {
    log('pressed delete');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note?'),
        content: const Text('Do you really want to delete this note?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                db
                    .deleteNote(
                      NoteData(
                        id: widget.noteCompanion.id.value,
                        title: widget.noteCompanion.title.value,
                        description: widget.noteCompanion.description.value,
                        priority: widget.noteCompanion.priority.value,
                        color: widget.noteCompanion.color.value,
                      ),
                    )
                    .then(
                      (value) => Navigator.pop(context, true),
                    );
              },
              child: const Text('Delete')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel')),
        ],
      ),
    );
  }
}
