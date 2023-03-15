import 'package:antiphrasis/src/models/gamecard.dart';
import 'package:antiphrasis/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class GameCardBloc {
  final _repository = Repository();
  final _gamecardsFetcher = PublishSubject<List<GameCard>>();
  final _currentGamecardFetcher = PublishSubject<GameCard?>();
  final _isLastQuestionFetcher = PublishSubject<bool>();

  List<GameCard> _gamecardsOfGroup = [];
  GameCard? _currentGamecard;
  bool isLastQuestion = false;

  Stream<List<GameCard>> get gamecardsForGroup => _gamecardsFetcher.stream;
  Stream<GameCard?> get gamecard => _currentGamecardFetcher.stream;

  fetchGameCardListForGroup(int groupId, int? indexGamecard) async {
    _currentGamecard = null;

    _gamecardsOfGroup = await _repository.fetchGamecardsForGroup(groupId);
    _gamecardsFetcher.sink.add(_gamecardsOfGroup);

    getNextGameCard(indexGamecard);
  }

  getNextGameCard(int? indexGamecard) async {
    // A changer quand il y a aura les groupes et la continuité
    int nextIndex = indexGamecard ?? _gamecardsOfGroup.indexOf(_currentGamecard!) + 1;

    if (nextIndex >= _gamecardsOfGroup.length) {
      _currentGamecard = null;
    } else {
      if (nextIndex == _gamecardsOfGroup.length - 1) {
        isLastQuestion = true;
      } else {
        isLastQuestion = false;
      }
      try {
        _currentGamecard = _gamecardsOfGroup[nextIndex];
        _currentGamecardFetcher.sink.add(null);
        _currentGamecardFetcher.sink.add(_currentGamecard);
      } on Exception catch (_) {}
    }
  }

  bool checkAnswer(String answer) {
    return answer.toLowerCase().trim() == _currentGamecard!.answer.toLowerCase();
  }

  dispose() {
    _gamecardsFetcher.close();
    _currentGamecardFetcher.close();
  }
}

final bloc = GameCardBloc();
