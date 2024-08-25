import 'package:flame_audio/flame_audio.dart';

import 'package:flame_audio/flame_audio.dart';

Future<void> loadAudio() async {
  final audioCache = FlameAudio.audioCache;

  // Load negative audio files
  for (int i = 1; i <= 5; i++) {
    final file = 'negative ($i).wav';
    try {
      await audioCache.load(file);
      print('Loaded $file successfully');
    } catch (e) {
      print('Error loading $file: $e');
    }
  }

  // Load positive audio files
  for (int i = 1; i <= 12; i++) {
    final file = 'positive ($i).wav';
    try {
      await audioCache.load(file);
      print('Loaded $file successfully');
    } catch (e) {
      print('Error loading $file: $e');
    }
  }
  await audioCache.load('Gong10.wav');
  await audioCache.load('Alert1.wav');
}

void playMove(int points) {
  if (points > 0) {
    final clampedPoints = points > 12 ? 12 : points; // Clamp to 12
    playAudio('positive ($clampedPoints).wav');
  } else if (points < 0) {
    final clampedPoints = points < -5 ? -5 : points; // Clamp to -5
    playAudio('negative (${clampedPoints.abs()}).wav');
  }
}

Future<void> playAudio(String file) async {
  FlameAudio.play(file);
}

void playStart() {
  FlameAudio.play('Gong10.wav');
}

void playTimeUp() {
  FlameAudio.play('Alert1.wav');
}
