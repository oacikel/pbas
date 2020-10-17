import 'package:pbas/model/objects/Post.dart';
import 'package:pbas/model/objects/User.dart';

class Repository {
  static final Repository _repository = Repository._internal();
  factory Repository() {
    return _repository;
  }
  Repository._internal();

  int _selectedChapterIndex;
  User _currentUser;
  List<Post> _totalPostList;


  List<Post> get totalPostList => _totalPostList;
  set totalPostList(List<Post> value) {_totalPostList = value;}

  int get selectedChapterIndex => _selectedChapterIndex;
  set selectedChapterIndex(int value) {_selectedChapterIndex = value;}

  User get currentUser => _currentUser;
  set currentUser(User value) {_currentUser = value;}
}