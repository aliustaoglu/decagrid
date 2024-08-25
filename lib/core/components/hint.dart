import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:decagrid/core/utils/globals.dart';
import 'package:decagrid/core/utils/sprite_util.dart';
import 'package:decagrid/core/utils/text_styles.dart';

class Hint extends PositionComponent {
  double posx;
  double posy;
  late TextComponent hintText;
  late TextComponent hintTitle;
  Function onReset;

  Hint({
    super.key,
    required this.posx,
    required this.posy,
    required this.onReset,
  });

  @override
  Future<void> onLoad() async {
    position = Vector2(posx, posy);
    hintTitle = TextComponent(
      text: 'Hint:',
      position: Vector2(40, 10),
      textRenderer: hintTextStyle,
      anchor: Anchor.topCenter,
    );
    hintText = TextComponent(
      text: globalHintText,
      position: Vector2(40, 25),
      textRenderer: hintTextStyle,
      anchor: Anchor.topCenter,
    );

    final imgBtnDef = await Flame.images.load('btnRestartDef.png');
    final imgBtnSel = await Flame.images.load('btnRestartSel.png');
    final sprBtnDef = getSprite(imgBtnDef, 380, 98, 0, 0, 0, 0);
    final sprBtnSel = getSprite(imgBtnSel, 380, 98, 0, 0, 0, 0);
    final btn = SpriteButtonComponent(
      button: sprBtnDef.sprite,
      buttonDown: sprBtnSel.sprite,
      anchor: Anchor.center,
      position: Vector2(40, 100),
      onPressed: () {
        onReset();
      },
    );
    btn.scale = Vector2.all(0.12);

    addAll(
      [hintTitle, hintText, btn],
    );

    super.onLoad();
  }

  @override
  void update(double dt) {
    hintTitle?.text = globalHintTitle;
    hintText?.text = globalHintText;
    hintText.textRenderer = getHintTextStyle(globalPoints);
    super.update(dt);
  }
}
