import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:decagrid/Tenscape.dart';
import 'package:decagrid/game_bg.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final game = Tenscape();
  runApp(
    MouseRegion(
      cursor: SystemMouseCursors.none,
      child: GameWidget(
        game: game,
        backgroundBuilder: (context) {
          return GameBg();
        },
      ),
    ),
  );
}
