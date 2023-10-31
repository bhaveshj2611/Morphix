// import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
// import 'package:mobile_music_player_lyrics/constants/colors.dart';
// import 'package:mobile_music_player_lyrics/constants/strings.dart';
// import 'package:mobile_music_player_lyrics/models/music.dart';
// import 'package:mobile_music_player_lyrics/views/lyrics_page.dart';
import 'package:music_recommender/models/music.dart';

// import 'package:palette_generator/palette_generator.dart';
// import 'package:spotify/spotify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// import 'widgets/art_work_image.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key, this.music});
  final Music? music;
  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final player = AudioPlayer();
  Duration? duration;
  // Music music = Music(trackId: '7MXVkk9YMctZqd1Srtv4MB');
  var loading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    // player = AudioPlayer();
    final yt = YoutubeExplode();
    player.state = PlayerState.playing;
    yt.search.search(widget.music!.name + widget.music!.artist).then((videos) {
      final video = videos.first;
      duration = video.duration;
      final videoId = video.id.value;

      yt.videos.streamsClient.getManifest(videoId).then((manifest) {
        final audioUrl = manifest.audioOnly.last.url;
        player.play(UrlSource(audioUrl.toString()));
        setState(() {});
      });
    });
    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    player.stop();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () async {
        // Stop and dispose of the audio player when the user goes back
        player.stop();
        player.dispose();
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF111427),
        body: loading
            ? const CircularProgressIndicator()
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/logo1.png',
                            width: 32,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Singing Now',
                                style: textTheme.bodyMedium
                                    ?.copyWith(color: Colors.cyan[50]),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.music!.artist,
                                    style: textTheme.bodyLarge
                                        ?.copyWith(color: Colors.white),
                                  )
                                ],
                              )
                            ],
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(Icons.close,
                                  color: Color.fromARGB(255, 255, 255, 255))),
                        ],
                      ),
                      Expanded(
                          flex: 2,
                          child: Center(
                            child: Image.network(widget.music!.imageLink),
                          )),
                      Expanded(
                          child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.music!.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.titleLarge
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    widget.music!.artist,
                                    style: textTheme.titleMedium
                                        ?.copyWith(color: Colors.white54),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          StreamBuilder(
                              stream: player.onPositionChanged,
                              builder: (context, data) {
                                return ProgressBar(
                                  progress:
                                      data.data ?? const Duration(seconds: 0),
                                  total: duration ?? const Duration(minutes: 4),
                                  bufferedBarColor: Colors.white38,
                                  baseBarColor: Colors.white10,
                                  thumbColor: Colors.white,
                                  timeLabelTextStyle:
                                      const TextStyle(color: Colors.white),
                                  progressBarColor: Colors.white,
                                  onSeek: (duration) {
                                    player.seek(duration);
                                  },
                                );
                              }),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.lyrics_outlined,
                                      color: Colors.white)),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.skip_previous,
                                      color: Colors.white, size: 36)),
                              IconButton(
                                onPressed: () async {
                                  if (player.state == PlayerState.playing) {
                                    await player.pause();
                                  } else {
                                    await player.resume();
                                  }
                                  setState(() {});
                                },
                                icon: Icon(
                                  player.state == PlayerState.playing
                                      ? Icons.pause
                                      : Icons.play_circle,
                                  color: Colors.white,
                                  size: 60,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.skip_next,
                                      color: Colors.white, size: 36)),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.loop,
                                      color: Colors.white)),
                            ],
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
