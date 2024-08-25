import 'package:flame/components.dart';
import 'package:flame/camera.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/widgets.dart';
import 'package:decagrid/core/utils/audio.dart';
import 'package:decagrid/core/utils/globals.dart';
import 'package:decagrid/core/utils/sprite_util.dart';
import 'package:decagrid/worlds/game_world.dart';

class Tenscape extends FlameGame {
  late GameWorld mainMenu;
  late CameraComponent cameraComponent;
  void onReset() {
    remove(mainMenu);
    if (camera.parent != null) {
      remove(camera);
    }
    resetGlobals();

    initWorld();
  }

  Future<void> initWorld() async {
    mainMenu = GameWorld(onReset: onReset);
    cameraComponent = CameraComponent.withFixedResolution(
      world: mainMenu,
      width: 320,
      height: 180,
    );
    mainMenu.camera = cameraComponent;

    addAll([
      mainMenu,
      cameraComponent,
    ]);
    playStart();
  }

  @override
  Future<void> onLoad() async {
    await loadAudio();
    initWorld();
  }
}
