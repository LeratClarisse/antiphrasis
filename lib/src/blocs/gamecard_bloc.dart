import 'package:antiphrasis/src/models/gamecard.dart';
import 'package:antiphrasis/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class GameCardBloc {
  final _repository = Repository();
  final _gamecardsFetcher = PublishSubject<List<GameCard>>();
  final _currentGamecardFetcher = PublishSubject<GameCard?>();

  List<GameCard> _gamecardsOfGroup = [];
  GameCard? _currentGamecard;

  Stream<List<GameCard>> get gamecardsForGroup => _gamecardsFetcher.stream;
  Stream<GameCard?> get gamecard => _currentGamecardFetcher.stream;

  fetchGameCardListForGroup(int groupId) async {
    _currentGamecard = null;
    
    _gamecardsOfGroup = await _repository.fetchGameCardListForGroup(groupId);
    _gamecardsFetcher.sink.add(_gamecardsOfGroup);

    getNextGameCard();
  }

  getNextGameCard() async {
    // A changer quand il y a aura les groupes et la continuit√©
    int nextIndex = _currentGamecard == null ? 1 : _currentGamecard!.id + 1;

    try {
      _currentGamecard = _gamecardsOfGroup.firstWhere((gc) => gc.id == nextIndex);
      _currentGamecardFetcher.sink.add(null);
      _currentGamecardFetcher.sink.add(_currentGamecard);
    } on Exception catch (_) {}
  }

  bool checkAnswer(String answer){
    return answer.toLowerCase().trim() == _currentGamecard!.answer.toLowerCase();
  }

  dispose() {
    _gamecardsFetcher.close();
    _currentGamecardFetcher.close();
  }
}

final bloc = GameCardBloc();
