import 'package:antiphrasis/src/ui/game.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      fixedSize: const Size(200, 70),
      padding: const EdgeInsets.all(0),
    );

    return Scaffold(
        body: Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        const AspectRatio(aspectRatio: 1.2, child: Image(image: AssetImage("assets/icons/logo_full.png"))),
        const SizedBox(height: 40),
        ElevatedButton(
          style: style,
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Game()),
            );
          },
          child: const Text('Jouer'),
        ),
      ]),
    ));
  }
}
