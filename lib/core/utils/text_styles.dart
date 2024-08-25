import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/widgets.dart';

final scoreBoardTextStyle = TextPaint(
  style: TextStyle(
    fontSize: 8.0,
    color: BasicPalette.lightGreen.color,
    fontFamily: 'Kaph',
  ),
);

final hintTextStyle = TextPaint(
  style: TextStyle(
    fontSize: 4.0,
    color: BasicPalette.lightGreen.color,
    fontFamily: 'Kaph',
  ),
);

TextPaint getHintTextStyle(points) {
  return TextPaint(
    style: TextStyle(
      fontSize: 4.0,
      color:
          points < 0 ? BasicPalette.red.color : BasicPalette.lightGreen.color,
      fontFamily: 'Kaph',
    ),
  );
}
