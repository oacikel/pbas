class Repository {
  static final Repository _repository = Repository._internal();
  factory Repository() {
    return _repository;
  }
  Repository._internal();

  int _selectedChapterIndex;

  int get selectedChapterIndex => _selectedChapterIndex;

  set selectedChapterIndex(int value) {
    _selectedChapterIndex = value;
  }
}