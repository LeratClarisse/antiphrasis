import 'package:antiphrasis/src/models/group.dart';
import 'package:antiphrasis/src/ui/home.dart';
import 'package:flutter/material.dart';

import '../blocs/group_bloc.dart';

class ChooseLevel extends StatefulWidget {
  const ChooseLevel({Key? key}) : super(key: key);

  @override
  _ChooseLevelState createState() => _ChooseLevelState();
}

class _ChooseLevelState extends State<ChooseLevel> {
  final List<bool> _isOpen = [false, false];

  @override
  void initState() {
    bloc.fetchGroupList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Home()),
          );
          return false;
        },
        child: Scaffold(
            body: StreamBuilder(
                stream: bloc.allGroups,
                builder: (context, AsyncSnapshot<List<Group>?> snapshot) {
                  if (snapshot.hasData) {
                    return Center(child: SingleChildScrollView(child: Container(child: listLayout(snapshot.data!))));
                  } else {
                    return const Text('Something bad happenned');
                  }
                })));
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
              body: gridLayout(entry.value.nbLevelsInGroup));
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

  GridView gridLayout(int nbLevelsInGroup) {
    return GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 5,
        children: gridContent(nbLevelsInGroup));
  }

  List<Container> gridContent(int nbLevelsInGroup) {
    return List.generate(nbLevelsInGroup, (index) {
      return Container(
        padding: const EdgeInsets.all(8),
        color: Colors.teal[300],
        child: Text((index + 1) as String),
      );
    });
  }
}
