import 'package:flutter/material.dart';

import '../database/database.dart';

class NoteGridTile extends StatelessWidget {
  final NoteData noteData;
  final Function() onTap;
  const NoteGridTile({
    required this.noteData,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // margin: const EdgeInsets.symmetric(
        //   horizontal: 10,
        //   vertical: 8,
        // ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    noteData.title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Text(
                  _getPriority(noteData.priority),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Text(
                noteData.description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '12/12/2021',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _getPriority(int priority) {
    switch (priority) {
      case 1:
        return '!!!';
      case 2:
        return '!!';
      default:
        return '!';
    }
  }
}
