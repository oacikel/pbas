import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbas/model/CONSTANTS.dart' as CONSTANTS;

import '../Chapter.dart';

class AudioPlayerController extends StatefulWidget {
   Chapter chapter;
   AudioPlayerController(this.chapter);

  @override
  _AudioPlayerControllerState createState() => _AudioPlayerControllerState(chapter);
}

class _AudioPlayerControllerState extends State<AudioPlayerController> {
  String _LOG_TAG ="OCULCAN - AudioPlayerController: ";
   Chapter chapter;
   AudioPlayer _audioPlayer=new AudioPlayer();
   Icon _playPauseIcon=Icon(Icons.play_arrow);
   String _currentTime="";
   String _totalTime="";
   double _seekPosition;
  _AudioPlayerControllerState(this.chapter);

  @override
  void initState() {

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
                        Text("00:00",
                          style: CONSTANTS.styleNormalFontBlack,),
                        Slider(value: 0.0,
                            onChanged:(value){setState(() {});},
                            max: 100,
                            min: 0,
                        ),
                        Text(_totalTime,
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
        debugPrint(_LOG_TAG+"Playing audiofile");
        _audioPlayer.play(widget.chapter.audioLink);
        _playPauseIcon=Icon(Icons.pause);
        _totalTime=_audioPlayer.duration.inSeconds.toString();
        setState(() {});
        break;
      case AudioPlayerState.STOPPED:
        debugPrint(_LOG_TAG+"Playing audiofile");
        _audioPlayer.play(widget.chapter.audioLink);
        _playPauseIcon=Icon(Icons.pause);
        _totalTime=_audioPlayer.duration.inSeconds.toString();
        setState(() {});
        break;
      case AudioPlayerState.PLAYING:
        debugPrint(_LOG_TAG+"Pausing audio");
        _audioPlayer.pause();
        _playPauseIcon=Icon(Icons.play_arrow);
        setState(() {});
        break;
      case AudioPlayerState.COMPLETED:
        debugPrint(_LOG_TAG+"Playing audiofile");
        _audioPlayer.play(widget.chapter.audioLink);
        _playPauseIcon=Icon(Icons.pause);
        _totalTime=_audioPlayer.duration.inSeconds.toString();
        setState(() {});
        break;
    }

    void _setAudioDuration(String url){
      _totalTime=_audioPlayer.duration.inSeconds.toString();
      setState(() {});
    }

  }
}
