import 'package:antiphrasis/src/models/gamecard.dart';
import 'package:antiphrasis/src/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../blocs/gamecard_bloc.dart';

class Game extends StatefulWidget {
  final int groupId;

  const Game(this.groupId, {Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  final fieldText = TextEditingController();

  @override
  void initState() {
    bloc.fetchGameCardListForGroup(widget.groupId);
    super.initState();
  }

  void clearText() {
    fieldText.clear();
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
                stream: bloc.gamecard,
                builder: (context, AsyncSnapshot<GameCard?> snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      Text(snapshot.data!.question),
                      const SizedBox(height: 30),
                      TextField(
                        controller: fieldText,
                        onSubmitted: (String answer) {
                          if (bloc.checkAnswer(answer)) {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text('Bravo !'),
                                      content: const Text('Vous avez trouvé la bonne réponse'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(builder: (context) => const Home()),
                                            );
                                          },
                                          child: const Text('Accueil'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            clearText();
                                            bloc.getNextGameCard();
                                          },
                                          child: const Text('Suivant'),
                                        ),
                                      ],
                                    ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Mauvaise réponse', textAlign: TextAlign.center, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(milliseconds: 1500)),
                            );
                          }
                        },
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(hintText: 'Réponse'),
                      )
                    ]));
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return const Text('Something bad happenned');
                  }
                })));
  }
}
