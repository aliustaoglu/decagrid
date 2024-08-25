import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';
import 'package:decagrid/core/components/score_board.dart';
import 'package:decagrid/core/components/single_digit.dart';
import 'package:decagrid/core/utils/audio.dart';
import 'package:decagrid/core/utils/globals.dart';
import 'package:decagrid/core/utils/sprite_util.dart';
import 'package:decagrid/core/utils/string_utils.dart';

class GameWorld extends World
    with
        TapCallbacks,
        DragCallbacks,
        HasGameRef<FlameGame>,
        PointerMoveCallbacks {
  late CameraComponent camera;
  double dragStartX = 0;
  double dragEndX = 0;
  double dragStartY = 0;
  double dragEndY = 0;
  late RectangleComponent rectangleComponent;
  late ScoreBoard scoreBoard;
  int score = 0;
  late SpriteComponent mouseCursor;
  double px = 0;
  double py = 0;
  Function onReset;

  GameWorld({super.key, required this.onReset});

  @override
  Future<void> onLoad() async {
    final canvasBackground = RectangleComponent(
      size: camera.viewport.size,
      paint: Paint()..color = const Color.fromARGB(255, 6, 2, 20),
    );
    add(canvasBackground);
    final rnd = Random();

    for (int i = 0; i < 15; i++) {
      for (int j = 0; j < 11; j++) {
        final r = rnd.nextInt(9) + 1;
        final digit = SingleDigit(
          key: ComponentKey.named('SingleDigit:$i:$j'),
          digit: r,
        );
        digit.position = Vector2(i * 16 + 4, j * 16 + 4);
        add(digit);
      }
    }

    camera.viewfinder.position = Vector2(160, 90);

    final position = Vector2(0, 0);
    final size = Vector2(0, 0);

    final paint = Paint()
      ..color = BasicPalette.lightGreen.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    rectangleComponent = RectangleComponent(
      position: position,
      size: size,
      paint: paint,
      anchor: Anchor.topLeft,
    );

    final spriteSheet = await Flame.images.load('pointer.png');
    mouseCursor = getSprite(
      spriteSheet,
      40,
      48,
      0,
      0,
      50,
      50,
    );
    mouseCursor.scale = Vector2.all(0.2);

    add(rectangleComponent);
    scoreBoard = ScoreBoard(posx: 240, posy: 0, score: score, onReset: onReset);
    add(scoreBoard);
    add(mouseCursor);
  }

  @override
  void onTapDown(TapDownEvent event) {
    dragStartX = event.localPosition.x;
    dragStartY = event.localPosition.y;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    isHover = true;

    px = event.localStartPosition.x;
    py = event.localStartPosition.y;

    if (dragStartX == 0 && dragStartY == 0) {
      dragStartX = event.localStartPosition.x;
      dragStartY = event.localStartPosition.y;
    } else {
      dragEndX = event.localStartPosition.x;
      dragEndY = event.localStartPosition.y;
    }

    final [xs, xe, ys, ye] = getXY();

    List<SingleDigit> digits = [];
    for (int i = xs; i < xe; i++) {
      for (int j = ys; j < ye; j++) {
        final digit = getSingleDigit('SingleDigit:$i:$j');
        if (digit.digit > -1) {
          digit.isHoverMe = true;
        }
      }
    }

    if (!(xe == 0 && ye == 0)) {
      final position = Vector2(xs * 16.0, ys * 16.0);
      final size = Vector2((xe - xs) * 16.0, (ye - ys) * 16.0);

      rectangleComponent.position = position;
      rectangleComponent.size = size;
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (isGameOver) {
      globalHintText = "Game Over";
      return;
    }
    super.onDragEnd(event);
    isHover = false;
    globalHintText = '';
    globalHintTitle = '';
    final [xs, xe, ys, ye] = getXY();

    List<SingleDigit> digits = [];
    var total = 0;
    for (int i = xs; i < xe; i++) {
      for (int j = ys; j < ye; j++) {
        final digit = getSingleDigit('SingleDigit:$i:$j');
        if (digit.digit > -1) {
          digit.isHoverMe = false;
          digits.add(digit);
          total += digit.digit;
        }
      }
    }

    if (total == 10) {
      globalPoints =
          ((rectangleComponent.size.x * rectangleComponent.size.y) / 256)
              .floor();

      for (final d in digits) {
        d.removeMe();
      }
      score = score + globalPoints;

      globalHintText = generateHintText(globalPoints);
      globalProgress += (globalPoints * 1 / 60).clamp(0, 1);
      if (globalProgress > 1) {
        globalProgress = 1;
      }
      playMove(globalPoints);
    } else {
      globalPoints = -1 *
          ((rectangleComponent.size.x * rectangleComponent.size.y) / 256)
              .floor();
      globalHintText = generateHintText(globalPoints);
      score = score + globalPoints;
      globalProgress += (globalPoints * 1 / 60);
      playMove(globalPoints);
    }
    isGameOver = globalProgress < 0;
    if (isGameOver) {
      globalProgress = 0;
      globalHintText = "Game Over";
    }

    dragStartX = 0;
    dragEndX = 0;
    dragStartY = 0;
    dragEndY = 0;

    rectangleComponent.position = Vector2(0, 0);
    rectangleComponent.size = Vector2(0, 0);
  }

  List<int> getXY() {
    final x1 = (dragStartX / 16).floor();
    final x2 = (dragEndX / 16).floor();
    final y1 = (dragStartY / 16).floor();
    final y2 = (dragEndY / 16).floor();

    var xs = x2 > x1 ? x1 : x2;
    var xe = x2 > x1 ? x2 + 1 : x1 + 1;

    var ys = y2 > y1 ? y1 : y2;
    var ye = y2 > y1 ? y2 + 1 : y1 + 1;

    if (xe > 15) {
      xe = 15;
    }
    if (xs > 15) {
      xs = -1;
      xe = -1;
    }
    if (ys > 11) {
      ys = -1;
      ye = -1;
    }

    return [xs, xe, ys, ye];
  }

  SingleDigit getSingleDigit(String keyId) {
    return this.children.whereType<SingleDigit>().firstWhere(
          (component) => component.key == ComponentKey.named(keyId),
          orElse: () => SingleDigit(digit: -1),
        );
  }

  @override
  void update(double dt) {
    super.update(dt);
    scoreBoard?.score = score;
    mouseCursor?.position.x = px;
    mouseCursor?.position.y = py;
  }

  @override
  void onPointerMove(PointerMoveEvent event) {
    px = event.localPosition.x;
    py = event.localPosition.y;
    super.onPointerMove(event);
  }
}
