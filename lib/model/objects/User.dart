import 'Post.dart';

class User {
  final String userName;
  final String userPictureLink;
  Post _focusedPost;
  Post _selectedPost;

  User({
    this.userName,
    this.userPictureLink
  });

  Post get focusedPost => _focusedPost;

  set focusedPost(Post value) {
    _focusedPost = value;
  }

  Post get selectedPost => _selectedPost;

  set selectedPost(Post value) {
    _selectedPost = value;
  }
}
