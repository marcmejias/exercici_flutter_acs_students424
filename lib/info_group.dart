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
                  labelText: "Name Group",
                ),
                validator: (value) {
                  if (value != group.name) {
                    group.name = value.toString();
                  }
                  return null;
                },
              ),
              Divider(),
              TextFormField(
                initialValue: group.description,
                decoration: const InputDecoration(
                  labelText: "Description",
                ),
                validator: (value) {
                  if (value != group.description) {
                    group.description = value.toString();
                  }
                  return null;
                },
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.zero,
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Saved')),
                      );
                    }
                  },
                  child: const Text('Submit'),
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