import 'package:antiphrasis/src/models/gamecard.dart';
import 'package:antiphrasis/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class GameCardBloc {
  final _repository = Repository();
  final _gamecardFetcher = PublishSubject<List<GameCard>>();
  List<GameCard> gamecards = [];

  Stream<List<GameCard>> get gamecardsForGroup => _gamecardFetcher.stream;

  fetchGameCardListForGroup(groupId) async {
    gamecards = await _repository.fetchGameCardListForGroup(groupId);
    _gamecardFetcher.sink.add(gamecards);
  }

  dispose() {
    _gamecardFetcher.close();
  }
}

final bloc = GameCardBloc();