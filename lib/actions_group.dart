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
            title: Text("Open"),
            subtitle: Text("opens an unlocked door"),
            value: false,
            onChanged: (bool? value) {},
          ),
          Divider(),
          CheckboxListTile(
            title: Text("Close"),
            subtitle: Text("closes an open door"),
            value: false,
            onChanged: (bool? value) {},
          ),
          Divider(),
          CheckboxListTile(
            title: Text("Locked"),
            subtitle: Text("locks a door or all the doors in a room or a group of rooms, if closed"),
            value: false,
            onChanged: (bool? value) {},
          ),
          Divider(),
          CheckboxListTile(
            title: Text("Unlock"),
            subtitle: Text("Unlocks a locked door or all the locked doors in a room"),
            value: false,
            onChanged: (bool? value) {},
          ),
          Divider(),
          CheckboxListTile(
            title: Text("Unlock shortly"),
            subtitle: Text("Unlocks a door during 10 seconds and locks it if it is closed"),
            value: false,
            onChanged: (bool? value) {},
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