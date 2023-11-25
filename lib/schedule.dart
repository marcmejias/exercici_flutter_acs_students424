import 'package:flutter/material.dart';
import 'data.dart';
import 'the_drawer.dart';
import 'group.dart';
import 'package:intl/intl.dart';
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
  static DateTime yesterday = yesterday = today.subtract(Duration(days:1));
  static DateTime mondayThisWeek = DateTime(today.year, today.month,
      today.day - today.weekday + 1);
  static DateTime sundayThisWeek = DateTime(today.year, today.month,
      today.day - today.weekday + 7);
  static DateTime initialDate = mondayThisWeek.subtract(new Duration(days:7));
  static DateTime finalDate = mondayThisWeek.subtract(new Duration(days:1));
  late DateTimeRange picker;


  TimeOfDay horaActual =TimeOfDay.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    picker = DateTimeRange(start: initialDate, end: finalDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule employees'),
      ),
      body: Center(
        child: Column(
          children: [
          Row(
              children:[ Container(
                width:100,
                child: const Text('From',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),

                Text(DateFormat('dd/MM/yyyy').format(picker.start)),
                IconButton(icon: Icon(Icons.calendar_month_sharp),
                  onPressed: () {
                    _pickFromDate();
                  },
                ),
              ],
            ),
            Row(
              children:[ Container(
                width:100,
                child: const Text('To',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),

                Text(DateFormat('dd/MM/yyyy').format(picker.end)),
                IconButton(icon: Icon(Icons.calendar_month_sharp),
                  onPressed: () {
                    _pickFromDate();
                  },
                ),
              ],
            ),
            Row(
              children:[
                Container(
                  width:200,
                  child: const Text('Weekdays',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),

                  Text(DateFormat('dd/MM/yyyy').format(picker.end)),
                  IconButton(icon: Icon(Icons.calendar_month_sharp),
                    onPressed: () {
                      _pickFromDate();
                    },
                  ),
              ],
            ),
            Row(
              children:[
                Container(
                  width:100,
                  child: const Text('From',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),

                Text(DateFormat('HH:mm').format(picker.start)),
                IconButton(icon: Icon(Icons.watch_later_outlined),
                  onPressed: () {
                    _pickFromTime();
                  },
                ),

              ],
            ),
            Row(
              children:[
                Container(
                  width:100,
                  child: const Text('To',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),

                Text(DateFormat('HH:mm').format(picker.end)),
                IconButton(icon: Icon(Icons.watch_later_outlined),
                  onPressed: () {
                    _pickFromTime();
                  },
                ),
              ],
            ),
            Row(children:[
              Container(
                width:200,
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20, ),
                  ),
                  onPressed: () {},
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
  _pickFromDate() async {

    DateTime? newStart = await showDatePicker(
      context: context,
      firstDate: DateTime(picker.start.year - 5),
      lastDate: DateTime(picker.start.year + 5),
      initialDate: picker.start,
    );
    late DateTime end;
    if (newStart !=null) {
      end = DateTime(
          picker.start.year + 1, picker.start.month, picker.start.day); // the present To date
    }
    if (end.difference(newStart!) >= Duration(days: 0)) {
      picker = DateTimeRange(start: newStart, end: end);
// x is where you store the (From,To) DateTime pairs
// associated to the ’Other’ option
      setState(() {
        selectedValue = "Other"; // to redraw the screen
      });
    } else {
      _showAlertDates();
    }
  }

  _pickFromTime() async {
    TimeOfDay? newStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (newStartTime != null) {
      DateTime newStartTimeDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        newStartTime.hour,
        newStartTime.minute,
      );

      DateTime end = newStartTimeDateTime.add(Duration(hours: 2));

      // Show the time picker for the second time selection
      TimeOfDay? newEndTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(end),
      );

      if (newEndTime != null) {
        DateTime newEndTimeDateTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          newEndTime.hour,
          newEndTime.minute,
        );

        if (newEndTimeDateTime.isAfter(end)) {
          // The second time is valid
          picker = DateTimeRange(start: newStartTimeDateTime, end: newEndTimeDateTime);

          setState(() {
            selectedValue = "Other";
          });
        } else {
          // Show an error because the second time is not later than the first
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("Selecciona una hora después de la primera hora."),
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
  }

  /*_pickFromTime() async {
    TimeOfDay? newStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (newStartTime != null) {
      DateTime combinedDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        newStartTime.hour,
        newStartTime.minute,
      );

      DateTime end = combinedDateTime.add(Duration(hours: 2));

      picker = DateTimeRange(start: combinedDateTime, end: end);

      setState(() {
        selectedValue = "Other";
      });
    }
  }
*/


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








