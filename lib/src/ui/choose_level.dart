import 'package:antiphrasis/src/ui/home.dart';
import 'package:flutter/material.dart';

class ChooseLevel extends StatefulWidget {
  const ChooseLevel({Key? key}) : super(key: key);

  @override
  _ChooseLevelState createState() => _ChooseLevelState();
}

class _ChooseLevelState extends State<ChooseLevel> {
  final List<bool> _isOpen = [false, false];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Home()),
          );
          return false;
        },
        child: Scaffold(body: Center(child: SingleChildScrollView(child: Container(child: listLayout())))));
  }

  ExpansionPanelList listLayout() {
    return ExpansionPanelList(
        children: listContent(),
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

  GridView gridLayout() {
    return GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 5,
        children: gridContent());
  }

  List<ExpansionPanel> listContent() {
    return <ExpansionPanel>[
      ExpansionPanel(
          backgroundColor: Colors.greenAccent[200],
          canTapOnHeader: true,
          isExpanded: _isOpen[0],
          headerBuilder: (context, isOpen) {
            return const Center(child: Text("Group 1", textAlign: TextAlign.center));
          },
          body: gridLayout()),
      ExpansionPanel(
          backgroundColor: Colors.greenAccent[200],
          canTapOnHeader: true,
          isExpanded: _isOpen[1],
          headerBuilder: (context, isOpen) {
            return const Center(child: Text("Group 2", textAlign: TextAlign.center));
          },
          body: gridLayout())
    ];
  }

  List<Container> gridContent() {
    return <Container>[
      Container(
        padding: const EdgeInsets.all(8),
        color: Colors.teal[300],
        child: const Text('1'),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        color: Colors.teal[300],
        child: const Text('2'),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        color: Colors.teal[300],
        child: const Text('3'),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        color: Colors.teal[300],
        child: const Text('4'),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        color: Colors.teal[300],
        child: const Text('5'),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        color: Colors.teal[300],
        child: const Text('6'),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        color: Colors.teal[300],
        child: const Text('7'),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        color: Colors.teal[300],
        child: const Text('8'),
      )
    ];
  }
}
