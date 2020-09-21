import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbas/model/Post.dart';
import 'package:pbas/widgets/PostTile.dart';


class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<Post>>(context);
    //debugPrint("OCULCAN - PostList: "+"PostList size: "+posts.length.toString());
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostTile(post:posts[index]);
        });
  }
}
