import 'package:flutter/material.dart';

import 'data.dart';
import 'group.dart';
import 'screen_list_groups.dart';

class ScreenInfo extends StatefulWidget {
  UserGroup group;

  ScreenInfo({super.key, required this.group});

  @override
  State<ScreenInfo> createState() => _ScreenInfoState();
}

class _ScreenInfoState extends State<ScreenInfo> {
  late UserGroup group;
  final _formKey = GlobalKey<FormState>();

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
      body: Form(
        key: _formKey,
        child: Container(
          child: Column(
            children: [
              TextFormField(
                initialValue: group.name,
                decoration: const InputDecoration(
                  hintText: "Name Group",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: group.description,
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: ElevatedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(content: Text("Saved"))
                    );
                  },
                ),
              ),
            ],
          ),
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