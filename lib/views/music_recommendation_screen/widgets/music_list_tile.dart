import 'package:flutter/material.dart';
import 'package:music_recommender/models/music.dart';
import 'package:music_recommender/music_player.dart';

class MusicListTile extends StatelessWidget {
  final Music music;
  final int index;

  const MusicListTile({super.key, required this.music, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // launchUrl(Uri.parse(music.link));
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return MusicPlayer(
              music: music,
            );
          },
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  music.imageLink,
                  width: 150,
                )),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    music.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    music.artist,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(Icons.more_horiz_outlined),
            //   color: Colors.white,
            // )
          ],
        ),
      ),
    );
  }
}
