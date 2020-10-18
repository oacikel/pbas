import 'dart:async';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pbas/model/constants/CONSTANTS.dart' as CONSTANTS;


import '../objects/Chapter.dart';
import '../objects/Story.dart';

class AudioPlayerController extends StatefulWidget {
   Story story;
   int order;
   bool isPlayerRestart;
   AudioPlayerController(this.story, this.order, this.isPlayerRestart);

  @override
  _AudioPlayerControllerState createState() => _AudioPlayerControllerState();
}

class _AudioPlayerControllerState extends State<AudioPlayerController> {
  String _LOG_TAG ="OCULCAN - AudioPlayerController: ";
   AudioPlayer _audioPlayer=new AudioPlayer();
   Icon _playPauseIcon;
   int _totalTime;
   String _totalTimeText;
   String _currentTimeText="00:00";
   double _sliderPosition;


  @override
  void initState() {
    super.initState();
    debugPrint(_LOG_TAG+"Initial audioplayer state is: "+_audioPlayer.state.toString());
    _playPauseIcon=Icon(Icons.play_arrow);
    _sliderPosition=0;
    _setAudioPlayer();
    ValueNotifier valueNotifier=new ValueNotifier(widget.isPlayerRestart);
    valueNotifier.addListener(() {
      if(widget.isPlayerRestart){
        debugPrint(_LOG_TAG+"Restarting audioplayer");
        _setAudioPlayer();
      }else{
        debugPrint(_LOG_TAG+"no change");
      }
    });
    valueNotifier.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {

        return Container(
          width: MediaQuery
              .of(context)
              .size
              .width ,
          height: 104,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(52.0),bottomLeft:Radius.circular(52.0))),
            child:Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8.0),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    child: CircleAvatar(backgroundImage: NetworkImage(widget.story.chapters[widget.order].imageLink),
                      radius: 40,),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      Container(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.story.chapters[widget.order].title,
                            style: CONSTANTS.styleBigFontBlack,
                            ),
                            Row(
                              children: [
                                Text(_currentTimeText,
                                style: CONSTANTS.styleNormalFontBlack,),
                                Text("/",
                                style: CONSTANTS.styleNormalFontBlack,),
                                Text((_totalTimeText),
                                style: CONSTANTS.styleNormalFontBlack,)],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 10,
                        child: Slider(value:_sliderPosition,
                            max: _totalTime.toDouble(),
                            min: 0,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: Icon(Icons.replay_30),
                            iconSize: 30,
                            onPressed: ((){}),
                          ), IconButton(
                            icon: Icon(_playPauseIcon.icon),
                            iconSize: 30,
                            onPressed: ((){_playOrPauseAudio(widget.story.chapters[widget.order].audioLink);}),
                          ),IconButton(
                            icon: Icon(Icons.forward_30),
                            iconSize: 30,
                            onPressed: ((){}),
                          ),
                        ],
                      )
                    ],),
                  ),
                  ],
              ),
            ) ,
          ),
        );
  }
  void _playOrPauseAudio(String url){
    //Update most reached chapter number first:
    if(widget.story.maxReachedStoryStop<=widget.order){
      setState(() {widget.story.maxReachedStoryStop=widget.order+1;});
    }
    switch (_audioPlayer.state){
      case AudioPlayerState.PAUSED:
        _updateTotalAudioDuration();
        debugPrint(_LOG_TAG+"Playing audio of chapter "+(widget.order+1).toString());
        debugPrint(_LOG_TAG+"url playing is "+url);
        _audioPlayer.play(url);
        break;
      case AudioPlayerState.STOPPED:
        _updateTotalAudioDuration();
        debugPrint(_LOG_TAG+"Playing audio of chapter "+(widget.order+1).toString());
        debugPrint(_LOG_TAG+"url playing is "+url);
        _audioPlayer.play(url);
        break;
      case AudioPlayerState.PLAYING:
        _audioPlayer.pause();
        debugPrint(_LOG_TAG+"Pausing audio.");
        break;
      case AudioPlayerState.COMPLETED:
        _updateTotalAudioDuration();
        debugPrint(_LOG_TAG+"Playing audio of chapter "+(widget.order+1).toString());
        debugPrint(_LOG_TAG+"url playing is "+url);
        _audioPlayer.play(url);
        break;
    }

  }
  void _setAudioPlayer(){
    _audioPlayer.stop();
    /**Update Total Duration*/
    _updateTotalAudioDuration();
    /**Observe AudioPlayer State Changes Here*/
    _audioPlayer.onPlayerStateChanged.listen((state) {
      _updateTotalAudioDuration();
      _setPlayerIcon();
    });
    /**Observe AudioPlayer Duration Changes Here*/
    _audioPlayer.onAudioPositionChanged.listen((duration) {
     _setSliderPosition(duration);
     _setCurrentTimeText(duration);
    });
  }
  _setPlayerIcon(){
    switch(_audioPlayer.state){

      case AudioPlayerState.STOPPED:
        debugPrint(_LOG_TAG+"Changing to play icon.");
        setState(() {
          _playPauseIcon=Icon(Icons.play_arrow);
        });
        break;
      case AudioPlayerState.PLAYING:
        debugPrint(_LOG_TAG+"Changing to pause icon.");
        setState(() {
          _playPauseIcon=Icon(Icons.pause);
        });
        break;
      case AudioPlayerState.PAUSED:
        debugPrint(_LOG_TAG+"Changing to play icon.");
        setState(() {
          _playPauseIcon=Icon(Icons.play_arrow);
        });
        break;
      case AudioPlayerState.COMPLETED:
        debugPrint(_LOG_TAG+"Changing to play icon.");
        setState(() {
          _playPauseIcon=Icon(Icons.play_arrow);
        });
        break;
    }
  }
  _setSliderPosition(Duration duration){
    setState(() { _sliderPosition=duration.inMilliseconds.toDouble();});
  }
  _setCurrentTimeText(Duration duration){
    setState(() {
      _currentTimeText=duration.toString().substring(2,7);
    });
  }
  _updateTotalAudioDuration(){
   setState(() {
     _totalTimeText=_audioPlayer.duration.toString().substring(2,7);
     _totalTime=_audioPlayer.duration.inMilliseconds;
   });
   debugPrint(_LOG_TAG+"Total clip duration is: "+_totalTime.toString());
  }
//
}
