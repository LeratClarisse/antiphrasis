import 'package:antiphrasis/src/models/group.dart';
import 'package:antiphrasis/src/ui/game.dart';
import 'package:antiphrasis/src/ui/home.dart';
import 'package:flutter/material.dart';

import '../blocs/group_bloc.dart';

class ChooseLevel extends StatefulWidget {
  const ChooseLevel({Key? key}) : super(key: key);

  @override
  _ChooseLevelState createState() => _ChooseLevelState();
}

class _ChooseLevelState extends State<ChooseLevel> {
  List<bool> _isOpen = [];

  @override
  void initState() {
    bloc.fetchGroupList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Antiphrasis'),
            ),
            body: StreamBuilder(
                stream: bloc.allGroups,
                builder: (context, AsyncSnapshot<List<Group>?> snapshot) {
                  if (snapshot.hasData) {
                    if (_isOpen.isEmpty) {
                      for (int i = 0; i < snapshot.data!.length; i++) {
                        _isOpen.add(false);
                      }
                    }
                    return Center(child: SingleChildScrollView(child: Container(child: listLayout(snapshot.data!))));
                  } else {
                    return const Text('Something bad happenned');
                  }
                }));
  }

  ExpansionPanelList listLayout(List<Group> groups) {
    return ExpansionPanelList(
        children: groups.asMap().entries.map((MapEntry<int, Group> entry) {
          return ExpansionPanel(
              backgroundColor: Colors.greenAccent[200],
              canTapOnHeader: true,
              isExpanded: _isOpen[entry.key],
              headerBuilder: (context, isOpen) {
                return Center(child: Text(entry.value.name, textAlign: TextAlign.center));
              },
              body: gridLayout(entry.value.nbLevelsInGroup, entry.value.id));
        }).toList(),
        expansionCallback: (i, isOpen) {
          setState(() {
            if (isOpen) {
              _isOpen[i] = !isOpen;
            } else {
              for (int j = 0; j < _isOpen.length; j++) {
                if (i == j) {
                  _isOpen[j] = !isOpen;
                } else {
                  _isOpen[j] = isOpen;
                }
              }
            }
          });
        });
  }

  GridView gridLayout(int nbLevelsInGroup, int groupId) {
    return GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 5,
        children: gridContent(nbLevelsInGroup, groupId));
  }

  List<GestureDetector> gridContent(int nbLevelsInGroup, int groupId) {
    return List.generate(nbLevelsInGroup, (index) {
      int index1Base = index + 1;
      return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Game(groupId, index)),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[300],
            child: Text(index1Base.toString()),
          ));
    });
  }
}
