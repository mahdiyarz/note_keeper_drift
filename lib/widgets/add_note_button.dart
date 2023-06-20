import 'package:flutter/material.dart';

class AddNoteButton extends StatelessWidget {
  final Function() onPressed;
  const AddNoteButton({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      shape: const CircleBorder(
        side: BorderSide(
          color: Colors.black,
          width: 2,
        ),
      ),
      backgroundColor: Colors.white,
      child: const Icon(
        Icons.add,
        color: Colors.black,
      ),
    );
  }
}
