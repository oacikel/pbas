import 'package:pbas/model/objects/User.dart';

class Repository {
  static final Repository _repository = Repository._internal();
  factory Repository() {
    return _repository;
  }
  Repository._internal();

  int _selectedChapterIndex;
  User _thisUser;
  int get selectedChapterIndex => _selectedChapterIndex;
  set selectedChapterIndex(int value) {
    _selectedChapterIndex = value;
  }

  User get thisUser => _thisUser;
  set thisUser(User value) {
    _thisUser = value;
  }
}