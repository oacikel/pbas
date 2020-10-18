import 'Post.dart';

class User {
  final String userName;
  final String userPictureLink;
  Post _focusedPost;
  Map <Post,int> _selectedPosts=new Map();

  User({
    this.userName,
    this.userPictureLink
  });

  Post get focusedPost => _focusedPost;

  set focusedPost(Post value) {
    _focusedPost = value;
  }

  Map<Post, int> get selectedPosts => _selectedPosts;

  set selectedPosts(Map<Post,int> value) {
    _selectedPosts = value;
  }
}
