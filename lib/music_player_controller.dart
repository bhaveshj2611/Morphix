import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_recommender/models/music.dart';
import 'package:music_recommender/music_player.dart';

class MusicPlayerController extends StatefulWidget {
  const MusicPlayerController(
      {super.key, required this.audioPlayer, required this.music});
  final AudioPlayer audioPlayer;
  final Music music;

  @override
  State<MusicPlayerController> createState() => _MusicPlayerControllerState();
}

class _MusicPlayerControllerState extends State<MusicPlayerController> {
  @override
  void initState() {
    super.initState();
    // Start playing the music here using widget.audioPlayer
    // You can add the logic to fetch and play the music as you did in MusicPlayer.
  }

  @override
  void dispose() {
    // Stop and dispose of the audio player when this widget is disposed.
    widget.audioPlayer.stop();
    widget.audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MusicPlayer(music: widget.music);
  }
}
