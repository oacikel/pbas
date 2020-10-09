import 'dart:async';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbas/model/CONSTANTS.dart' as CONSTANTS;

import '../Chapter.dart';

class AudioPlayerController extends StatefulWidget {
   Chapter chapter;
   AudioPlayerController(this.chapter);

  @override
  _AudioPlayerControllerState createState() => _AudioPlayerControllerState();
}

class _AudioPlayerControllerState extends State<AudioPlayerController> {
  String _LOG_TAG ="OCULCAN - AudioPlayerController: ";
   AudioPlayer _audioPlayer=new AudioPlayer();
   Icon _playPauseIcon;
   String _currentTime="";
   int _totalTime;
   String _totalTimeText;
   String _currentTimeText="00:00";
   double _sliderPosition;
   Stream _audioPlayerStateStream;

  @override
  void initState() {
    super.initState();
    debugPrint(_LOG_TAG+"Initial audioplayer state is: "+_audioPlayer.state.toString());
    _playPauseIcon=Icon(Icons.play_arrow);
    _sliderPosition=0;
    _setAudioPlayer();
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
                  CircleAvatar(backgroundImage: NetworkImage(widget.chapter.imageLink),
                    radius: 40,),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0, right:8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text(widget.chapter.title,
                      textAlign: TextAlign.left,),
                      Container(height: 20,
                        child: Row(
                          children: [
                            Text(_currentTimeText,
                              style: CONSTANTS.styleNormalFontBlack,),
                            Container(
                              width: 150,
                              child: Slider(value:_sliderPosition,
                                  onChanged:(value){setState(() {});},
                                  max: 11000,
                                  min: 0,
                              ),
                            ),
                            Text((_totalTimeText),
                              style: CONSTANTS.styleNormalFontBlack,)
                          ],),
                      ),
                      Container(
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.replay_30),
                              iconSize: 30,
                              onPressed: ((){}),
                            ), IconButton(
                              icon: Icon(_playPauseIcon.icon),
                              iconSize: 30,
                              onPressed: ((){_playOrPauseAudio(widget.chapter.audioLink);}),
                            ),IconButton(
                              icon: Icon(Icons.forward_30),
                              iconSize: 30,
                              onPressed: ((){}),
                            ),
                          ],
                        ),
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
    switch (_audioPlayer.state){
      case AudioPlayerState.PAUSED:
        _updateTotalAudioDuration();
        debugPrint(_LOG_TAG+"Playing audio.");
        _audioPlayer.play(widget.chapter.audioLink);

        break;
      case AudioPlayerState.STOPPED:
        _updateTotalAudioDuration();
        debugPrint(_LOG_TAG+"Playing audio.");
        _audioPlayer.play(widget.chapter.audioLink);
        break;
      case AudioPlayerState.PLAYING:
        _audioPlayer.pause();
        debugPrint(_LOG_TAG+"Pausing audio.");
        break;
      case AudioPlayerState.COMPLETED:
        _updateTotalAudioDuration();
        debugPrint(_LOG_TAG+"Playing audio.");
        _audioPlayer.play(widget.chapter.audioLink);
        break;
    }

  }
  void _setAudioPlayer(){
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
