import 'dart:math';

import 'package:flutter/material.dart';
import 'data.dart';
import 'the_drawer.dart';
import 'group.dart';
import 'package:intl/intl.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';
import 'package:weekday_selector/weekday_selector.dart';

class ScreenSchedule extends StatefulWidget {
  UserGroup group;

  ScreenSchedule({super.key, required this.group});

  @override
  State<ScreenSchedule> createState() => _ScreenScheduleState();
}

class _ScreenScheduleState extends State<ScreenSchedule> {
  late UserGroup group;

  String? selectedValue;
  String? selectedValue2;
  String? selectedValue3;
  static DateTime today = DateTime.now();
  static DateTime yesterday = yesterday = today.subtract(Duration(days: 1));
  static DateTime mondayThisWeek =
      DateTime(today.year, today.month, today.day - today.weekday + 1);
  static DateTime sundayThisWeek =
      DateTime(today.year, today.month, today.day - today.weekday + 7);
  late DateTimeRange picker;
  late TimeOfDay initialTime;
  late TimeOfDay finalTime;
  late DateTime initialDate;
  late DateTime finalDate;
  List<bool> values = List.filled(7, true);
  TimeOfDay horaActual = TimeOfDay.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    group = widget.group;
    initialDate = group.schedule.fromDate;
    finalDate = group.schedule.toDate;
    initialTime = group.schedule.fromTime;
    finalTime = group.schedule.toTime;
    picker = DateTimeRange(start: initialDate, end: finalDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text('Schedule ' + group.name),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  child: const Text(
                    'From',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                Text(DateFormat('dd/MM/yyyy').format(initialDate)),
                IconButton(
                  icon: Icon(Icons.calendar_month_sharp),
                  onPressed: () {
                    _pickFromDate(initialDate);
                  },
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  child: const Text(
                    'To',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                Text(DateFormat('dd/MM/yyyy').format(finalDate)),
                IconButton(
                  icon: Icon(Icons.calendar_month_sharp),
                  onPressed: () {
                    _pickToDate(finalDate);
                  },
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 200,
                  child: const Text(
                    'Weekdays',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                WeekdaySelector(
                  onChanged: (v) {
                    printIntAsDay(v);
                    setState(() {
                      values[v % 7] = !values[v % 7]!;
                    });
                  },
                  values: values,
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  child: const Text(
                    'From',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                Text(initialTime.format(context)),
                IconButton(
                  icon: Icon(Icons.watch_later_outlined),
                  onPressed: () {
                    _pickFromTime(initialTime);
                  },
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  child: const Text(
                    'To',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                Text(finalTime.format(context)),
                IconButton(
                  icon: Icon(Icons.watch_later_outlined),
                  onPressed: () {
                    _pickToTime(finalTime);
                  },
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 200,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      _submit();
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _submit() async {
    group.schedule.fromDate = picker.start;
    group.schedule.toDate = picker.end;
    group.schedule.fromTime = initialTime;
    group.schedule.toTime = finalTime;
    ScaffoldMessenger.of(context)
        .showSnackBar(
        const SnackBar(content: Text("Saved"))
    );
  }
  _pickFromDate(DateTime time) async {
    DateTime? newStart = await showDatePicker(
      context: context,
      firstDate: DateTime(time.year - 5),
      lastDate: DateTime(time.year + 5),
      initialDate: time,
    );
    if (newStart != null) {
      setState(() {
        selectedValue = "Other";
        initialDate = newStart;
      });
    }
  }
  _pickToDate(DateTime time) async {
    DateTime? newEnd = await showDatePicker(
      context: context,
      firstDate: DateTime(time.year - 5),
      lastDate: DateTime(time.year + 5),
      initialDate: time,
    );
    if (newEnd != null) {
      if (newEnd.difference(initialDate!) >= Duration(days: 0)) {
        picker = DateTimeRange(start: initialDate, end: newEnd);
        // x is where you store the (From,To) DateTime pairs
        // associated to the ’Other’ option
        setState(() {
          selectedValue = "Other"; // to redraw the screen
          finalDate = newEnd;
        });
      } else {
        _showAlertDates();
      }
    }
  }

  _pickFromTime(TimeOfDay time) async {
    TimeOfDay? newStartTime = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (newStartTime != null) {
      setState(() {
        selectedValue = "Other";
        initialTime = newStartTime;
      });
    }
  }
  _pickToTime(TimeOfDay time) async {
    TimeOfDay? newEndTime = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (newEndTime != null) {
      if (newEndTime.hour > initialTime.hour) {
        // The second time is valid
        //picker = DateTimeRange( start: newStartTime, end: newEndTime);
        setState(() {
          selectedValue = "Other";
          finalTime = newEndTime;
        });
      } else {
        // Show an error because the second time is not later than the first
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content:
              Text("Selecciona una hora valida."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
  }
  TextButton _showAlertDates() {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Range dates'),
          content: const Text('The From date is after the To date'
              'Please, select a new date.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('ACCEPT'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}

printIntAsDay(int day) {
  print('Received integer: $day. Corresponds to day: ${intDayToEnglish(day)}');
}

String intDayToEnglish(int day) {
  if (day % 7 == DateTime.monday % 7) return 'Monday';
  if (day % 7 == DateTime.tuesday % 7) return 'Tueday';
  if (day % 7 == DateTime.wednesday % 7) return 'Wednesday';
  if (day % 7 == DateTime.thursday % 7) return 'Thursday';
  if (day % 7 == DateTime.friday % 7) return 'Friday';
  if (day % 7 == DateTime.saturday % 7) return 'Saturday';
  if (day % 7 == DateTime.sunday % 7) return 'Sunday';
  throw '🐞 This should never have happened: $day';
}
