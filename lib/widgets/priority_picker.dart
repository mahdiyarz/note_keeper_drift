import 'package:flutter/material.dart';

class PriorityPicker extends StatefulWidget {
  int index;
  final Function(int) onTap;
  PriorityPicker({
    required this.index,
    required this.onTap,
    super.key,
  });

  @override
  State<PriorityPicker> createState() => _PriorityPickerState();
}

class _PriorityPickerState extends State<PriorityPicker> {
  final List<String> priorityList = [
    'Low',
    'High',
    'Very High',
  ];

  final List<Color> colorList = [
    Colors.green,
    Colors.redAccent,
    Colors.orangeAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: priorityList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              widget.index = index;
              widget.onTap(index);
              setState(() {});
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: MediaQuery.of(context).size.width * .28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black),
                color: widget.index == index ? colorList[index] : null,
              ),
              child: Center(
                  child: Text(
                priorityList[index],
                style: Theme.of(context).textTheme.labelLarge,
              )),
            ),
          );
        },
      ),
    );
  }
}
