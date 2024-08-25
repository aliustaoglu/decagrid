import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/widgets.dart';
import 'package:decagrid/core/utils/globals.dart';

final List<Color> colorPalette = [
  BasicPalette.brown.color,
  BasicPalette.blue.color,
  BasicPalette.cyan.color,
  BasicPalette.lightGray.color,
  BasicPalette.darkGreen.color,
  BasicPalette.lightOrange.color,
  BasicPalette.lightGreen.color,
  BasicPalette.magenta.color,
  BasicPalette.lightRed.color,
];

class SingleDigit extends PositionComponent with HoverCallbacks {
  final int digit;
  late RectangleComponent canvasBackground;
  bool isHoverMe = false;

  SingleDigit({
    ComponentKey? key,
    required this.digit,
  }) : super(key: key);

  @override
  FutureOr<void> onLoad() {
    canvasBackground = RectangleComponent(
      size: Vector2(16, 16),
      position: Vector2(-4, -4),
      paint: Paint()
        ..color = const Color.fromARGB(255, 168, 103, 17)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );

    final kaph = TextPaint(
      style: TextStyle(
        fontSize: 8.0,
        color: colorPalette[digit - 1],
        fontFamily: 'Kaph',
      ),
    );

    final tc = TextComponent(
      text: digit.toString(),
      textRenderer: kaph,
    );

    tc.position = Vector2(0, 0);
    size = Vector2(16, 16);

    add(canvasBackground);
    add(tc);
  }

  void removeMe() {
    this.removeFromParent();
  }

  @override
  void update(double dt) {
    // false && isHover && isHoverMe
    if (isGameOver) {
      var random = Random();
      canvasBackground?.position = Vector2(
          (random.nextDouble() * 2.0) - 5.0, (random.nextDouble() * 2.0) - 5.0);
    } else {
      canvasBackground?.position = Vector2(-4, -4);
    }

    super.update(dt);
  }

  @override
  void onHoverEnter() {
    isHover = true;
    isHoverMe = true;
    super.onHoverEnter();
  }

  @override
  void onHoverExit() {
    isHoverMe = false;
    super.onHoverExit();
  }

  /*@override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    removeFromParent();
  }*/
}
