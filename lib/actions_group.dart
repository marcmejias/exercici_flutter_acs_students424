import 'package:flutter/material.dart';

import 'data.dart';
import 'group.dart';
import 'screen_list_groups.dart';

class ScreenActions extends StatefulWidget {
  UserGroup group;

  ScreenActions({super.key, required this.group});

  @override
  State<ScreenActions> createState() => _ScreenActionsState();
}

class _ScreenActionsState extends State<ScreenActions> {
  late UserGroup group;
  bool checkboxValue1 = false;
  bool checkboxValue2 = false;
  bool checkboxValue3 = false;
  bool checkboxValue4 = false;
  bool checkboxValue5 = false;

  @override
  void initState() {
    super.initState();
    group = widget.group;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text("Info " + group.name),
      ),
      body: Column(
        children: <Widget>[
          CheckboxListTile(
            value: checkboxValue1,
            onChanged: (bool? value) {
              setState(() {
                checkboxValue1 = value!;
              });
            },
            title: const Text('Open'),
            subtitle: const Text('Opens an unlocked door'),
          ),
          Divider(),
          CheckboxListTile(
            title: const Text("Close"),
            subtitle: const Text("closes an open door"),
            value: checkboxValue2,
            onChanged: (bool? value) {
              setState(() {
                checkboxValue2 = value!;
              });
            },
          ),
          Divider(),
          CheckboxListTile(
            title: const Text("Locked"),
            subtitle: const Text("locks a door or all the doors in a room or a group of rooms, if closed"),
            value: checkboxValue3,
            onChanged: (bool? value) {
              setState(() {
                checkboxValue3 = value!;
              });
            },
          ),
          Divider(),
          CheckboxListTile(
            title: const Text("Unlock"),
            subtitle: const Text("Unlocks a locked door or all the locked doors in a room"),
            value: checkboxValue4,
            onChanged: (bool? value) {
              setState(() {
                checkboxValue4 = value!;
              });
            },
          ),
          Divider(),
          CheckboxListTile(
            title: const Text("Unlock shortly"),
            subtitle: const Text("Unlocks a door during 10 seconds and locks it if it is closed"),
            value: checkboxValue5,
            onChanged: (bool? value) {
              setState(() {
                checkboxValue5 = value!;
              });
            },
          ),
          Divider(),
          Padding(
              padding: EdgeInsets.zero,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                    const SnackBar(content: Text("Saved"))
                );
              },
              child: Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(UserGroup userGroup, int index) {
    return ListTile(
      title: Text(userGroup.name),
      trailing: Text('${userGroup.users.length}'),
      onTap: () {
        Navigator.of(context).pop(); // close drawer
        Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (context) => ScreenListGroups(userGroups: Data.userGroups),
        ));
      },
    );
  }
}