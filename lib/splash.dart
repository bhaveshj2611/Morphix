import 'package:flutter/material.dart';

import 'package:music_recommender/views/music_recommendation_screen/music_recommendation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void changeScreen() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const MusicRecommendationScreen();
        },
      ));
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF111427),
      child: Center(child: Image.asset('assets/Logo.png')),
    );
  }
}
