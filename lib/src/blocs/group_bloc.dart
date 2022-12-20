import 'package:antiphrasis/src/models/group.dart';
import 'package:antiphrasis/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class GroupBloc {
  final _repository = Repository();
  final _groupFetcher = PublishSubject<List<Group>>();
  List<Group> groups = [];

  Stream<List<Group>> get allGroups => _groupFetcher.stream;

  fetchGroupList() async {
    groups = await _repository.fetchGroupList();
    _groupFetcher.sink.add(groups);
  }

  dispose() {
    _groupFetcher.close();
  }
}

final bloc = GroupBloc();