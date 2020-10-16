import 'package:flutter/material.dart';
import 'package:pbas/screens/MapScreen/ChapterTile.dart';

import '../objects/Story.dart';

class FABWithChapters extends StatefulWidget {
  FABWithChapters({this.story, this.onIconTapped});
  final Story story;
  ValueChanged<int> onIconTapped;
  @override
  State createState() => FABWithChaptersState();
}

class FABWithChaptersState extends State<FABWithChapters> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
        ListView.builder(
          itemCount: widget.story.chapters.length,
          itemBuilder:(context,index){
            return _buildChild(index);
          }),
          _buildFab(),
        ]),
    ]
    );
  }

  Widget _buildChild(int index) {
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;
    return Container(
      color: Colors.black38,
      child: ScaleTransition(
        scale: CurvedAnimation(
          parent: _controller,
          curve: Interval(0.0,1.0 - index / widget.story.chapters.length / 2.0 ,curve: Curves.easeOut),
        ),
        child: ChapterTile(
          story: widget.story,
          order: index,
          ),
      ),
    );
  }

  Widget _buildFab() {
    return Container(
      color:Colors.black38,
      child: RaisedButton(
        onPressed: () {
          if (_controller.isDismissed) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        },
        child: Icon(Icons.book),
        elevation: 2.0,
      ),
    );
  }

  void _onTapped(int index) {
    _controller.reverse();
    widget.onIconTapped(index);
  }
}