import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

SpriteComponent getSprite(
  Image spriteSheet,
  double sizeX,
  double sizeY,
  int xIndex,
  int yIndex,
  double posX,
  double posY,
) {
  final spriteSize = Vector2(sizeX, sizeY);
  final x = xIndex * sizeX;
  final y = yIndex * sizeY;

  final sprite = Sprite(
    spriteSheet,
    srcPosition: Vector2(x, y),
    srcSize: spriteSize,
  );

  final spriteComponent = SpriteComponent(
    sprite: sprite,
    size: spriteSize,
    position: Vector2(posX, posY),
  );
  return spriteComponent;
}
