import 'package:exercise_flutter_acs/screen_partition.dart';
import 'package:flutter/material.dart';
import 'tree.dart';
import 'requests.dart';

class ScreenSpace  extends StatefulWidget {
  final String id;

  const ScreenSpace({super.key, required this.id});

  @override
  State<ScreenSpace > createState() => _ScreenSpaceState();
}

class _ScreenSpaceState  extends State<ScreenSpace> {
  late Future<Tree> futureTree;

  @override
  void initState() {
    super.initState();
    futureTree = getTree(widget.id);
  }
  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(tree.root.id),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.home),
              onPressed: () {}
            // TODO go home page = root
          ),
          //TODO other actions
        ],
      ),
      body: ListView.separated(
        // it's like ListView.builder() but better
        // because it includes a separator between items
        padding: const EdgeInsets.all(16.0),
        itemCount: tree.root.children.length,
        itemBuilder: (BuildContext context, int index) =>
            _buildRow(tree.root.children[index], index),
        separatorBuilder: (BuildContext context, int index) =>
        const Divider(),
      ),
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Tree>(
      future: futureTree,
      builder: (context, snapshot) {
        // anonymous function
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              title: Text(snapshot.data!.root.id),
              actions: <Widget>[
                IconButton(icon: const Icon(Icons.home), onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ScreenPartition(id: 'building'))
                  );
                }
                ),
                //TODO other actions
              ],
            ),
            body: ListView.separated(
              // it's like ListView.builder() but better because it includes a separator between items
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data!.root.children.length,
              itemBuilder: (BuildContext context, int i) =>
                  _buildRow(snapshot.data!.root.children[i], i),
              separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a progress indicator
        return Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ));
      },
    );
  }

  Widget _buildRow(Door door, int index) {
    return ListTile(
      leading: Builder(
        builder: (BuildContext context) => _stateDoor(door),
      ),
      title: Text(door.id),
      trailing: Builder(
        builder: (BuildContext context) => _stateLocked(door),
      ),
    );
  }

  Widget _stateDoor(Door door) {
    if (door.closed == true){
      return Icon (Icons.sensor_door_rounded);
    }
    else {
      return Icon(Icons.sensor_door_outlined);
    }
  }

  Widget _stateLocked(Door door) {
    if (door.state == 'LOCKED'){
      return Icon (Icons.lock);
    }
    else {
      return Icon(Icons.lock_open_outlined);
    }
  }
}