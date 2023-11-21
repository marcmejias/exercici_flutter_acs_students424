import 'package:flutter/material.dart';

import 'data.dart';
import 'info_group.dart';
import 'actions_group.dart';
import 'screen_list_groups.dart';
import 'schedule.dart';

class ScreenGroup extends StatefulWidget {
  UserGroup group;

  ScreenGroup({super.key, required this.group});

  @override
  State<ScreenGroup> createState() => _ScreenGroupState();
}

class _ScreenGroupState extends State<ScreenGroup> {
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
        title: Text("Group " + group.name),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 5,
          children: [
            Container(
              child: Center(
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // close drawer
                          Navigator.of(context).push(MaterialPageRoute<void>(
                            builder: (context) => ScreenInfo(group: group),
                          ));
                        },
                        icon: const Icon(Icons.dashboard),
                    ),
                    Text("Info"),
                  ],
                ),
              ),
            ),
            Container(
              child: Center(
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // close drawer
                        Navigator.of(context).push(MaterialPageRoute<void>(
                          builder: (context) => ScreenSchedule(group: group),
                        ));
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                    Text("Schedule"),
                  ],
                ),
              ),
            ),
            Container(
              child: Center(
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // close drawer
                        Navigator.of(context).push(MaterialPageRoute<void>(
                          builder: (context) => ScreenActions(group: group),
                        ));
                      },
                      icon: const Icon(Icons.door_back_door),
                    ),
                    Text("Actions"),
                  ],
                ),
              ),
            ),
            Container(
              child: Center(
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                      },
                      icon: const Icon(Icons.house),
                    ),
                    Text("Places"),
                  ],
                ),
              ),
            ),
            Container(
              child: Center(
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                      },
                      icon: const Icon(Icons.verified_user),
                    ),
                    Text("Users"),
                  ],
                ),
              ),
            )
          ],
        ),
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