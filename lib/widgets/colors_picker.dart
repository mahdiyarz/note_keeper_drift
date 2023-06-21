import 'package:flutter/material.dart';

List<Color> colors = [
  Colors.white,
  Colors.blue.shade400,
  Colors.green.shade400,
  Colors.pink.shade400,
  Colors.purple.shade400,
  Colors.orange.shade500,
  Colors.red.shade400,
  Colors.amber.shade500,
  Colors.brown.shade400,
  Colors.indigo.shade400,
  Colors.lime,
];

class ColorsPicker extends StatefulWidget {
  int index;
  final Function(int) onTap;
  ColorsPicker({required this.index, required this.onTap, super.key});

  @override
  State<ColorsPicker> createState() => _ColorsPickerState();
}

class _ColorsPickerState extends State<ColorsPicker> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: colors.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            widget.index = index;
            widget.onTap(index);
            setState(() {});
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 29,
                height: 29,
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  color: colors[index],
                ),
              ),
              widget.index == index
                  ? const Icon(Icons.check)
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
