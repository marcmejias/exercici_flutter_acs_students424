import 'package:flutter/material.dart';

import 'data.dart';
import 'the_drawer.dart';
import 'group.dart';

class ScreenSchedule extends StatefulWidget {
  UserGroup group;

  ScreenSchedule({super.key, required this.group});

  @override
  State<ScreenSchedule> createState() => _ScreenScheduleState();
}

class _ScreenScheduleState extends State<ScreenSchedule> {
  late UserGroup group;

  @override
  void initState() {
    super.initState();
    group = widget.group;
  }

  Widget build(BuildContext context) {
    return Scaffold();
  }
}