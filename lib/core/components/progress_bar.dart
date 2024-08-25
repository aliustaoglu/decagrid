import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:decagrid/core/utils/audio.dart';
import 'package:decagrid/core/utils/globals.dart';

class ProgressBar extends PositionComponent {
  final double width;
  final double height;
  final Paint backgroundPaint;
  final Paint progressPaint;

  ProgressBar({
    required this.width,
    required this.height,
    Color backgroundColor = Colors.grey,
    Color progressColor = Colors.green,
  })  : backgroundPaint = Paint()..color = backgroundColor,
        progressPaint = Paint()..color = progressColor,
        super(size: Vector2(width, height));

  @override
  Future onLoad() async {
    position.y = 180 - height - 5;
  }

  @override
  void render(Canvas canvas) {
    Rect rectBg = Rect.fromLTWH(0, 0, width, height);
    Rect rectFg = Rect.fromLTWH(0, 0, width * globalProgress, height);
    var pB = Paint()..color = const Color.fromARGB(255, 101, 102, 93);
    var pF = Paint()..color = Colors.lime;

    canvas.drawRect(rectBg, pB);
    canvas.drawRect(rectFg, pF);

    super.render(canvas);
  }

  @override
  void update(double dt) {
    if (isGameOver) {
      globalHintText = "Game Over";
      globalProgress = 0;
      playTimeUp();
      removeFromParent();
      return;
    }
    globalProgress = globalProgress - 1 / 3600;
    isGameOver = globalProgress < 0;
    super.update(dt);
  }
}
