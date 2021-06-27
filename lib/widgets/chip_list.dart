import 'package:flutter/material.dart';
import 'package:not_apple_solutions/models/chip_info.dart';

class ChipList extends StatefulWidget {
  final List<String> chips;
  const ChipList({Key? key, required this.chips}) : super(key: key);

  @override
  State createState() => ChipListState();
}

class ChipListState extends State<ChipList> {

  final _chipInfo = <ChipInfo>[];

  Iterable<Widget> get chipWidgets sync* {
    for (final ChipInfo chip in _chipInfo.where((c) => !c.dismissed)) {
      yield Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Chip(
          label: Text(chip.info),
          labelStyle: TextStyle(fontSize: 10.0),
          deleteIcon: Icon(Icons.cancel_sharp, size: 10.0),
          backgroundColor: Theme.of(context).splashColor,
          labelPadding: EdgeInsets.only(left: 8.0),
          useDeleteButtonTooltip: false,
          onDeleted: () {
            setState(() {
              chip.dismissed = true;
            });
          },
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _chipInfo.addAll(widget.chips.map((e) => ChipInfo(e)));
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: chipWidgets.toList(),
    );
  }
}
