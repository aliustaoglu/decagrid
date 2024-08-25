import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flutter/widgets.dart';
import 'package:decagrid/core/components/hint.dart';
import 'package:decagrid/core/components/progress_bar.dart';
import 'package:decagrid/core/utils/globals.dart';
import 'package:decagrid/core/utils/sprite_util.dart';
import 'package:decagrid/core/utils/text_styles.dart';

class ScoreBoard extends PositionComponent {
  final double posx;
  final double posy;
  late int score;
  late TextComponent scoreText;
  late TextComponent scoreTitle;
  late NineTileBox blueSquare;
  Function onReset;

  ScoreBoard({
    super.key,
    required this.posx,
    required this.posy,
    required this.score,
    required this.onReset,
  });

  @override
  Future<void> onLoad() async {
    position = Vector2(posx, posy);
    scoreTitle = TextComponent(
      text: 'Score',
      position: Vector2(40, 6),
      textRenderer: scoreBoardTextStyle,
      anchor: Anchor.topCenter,
    );
    scoreText = TextComponent(
      text: score.toString(),
      position: Vector2(40, 20),
      textRenderer: scoreBoardTextStyle,
      anchor: Anchor.topCenter,
    );
    final bgPaint = Paint()..color = BasicPalette.lightOrange.color;
    final bg = RectangleComponent(
      position: Vector2(0, 0),
      size: Vector2(80, 177),
      paint: bgPaint,
    );
    final progressBar = ProgressBar(
      width: 80,
      height: 10,
    );

    final imgBlueSquare = await Flame.images.load('element_blue_square.png');

    blueSquare = NineTileBox(Sprite(imgBlueSquare), tileSize: 16);
    final comp = NineTileBoxComponent(nineTileBox: blueSquare);

    comp.size = Vector2(80, 164);
    comp.position = Vector2(0, 0);
    final hint = Hint(posx: 0, posy: 40, onReset: onReset);

    addAll([
      bg,
      comp,
      hint,
      scoreTitle,
      scoreText,
      progressBar,
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    scoreText?.text = score.toString();
  }
}
