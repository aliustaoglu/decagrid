import 'package:flame/palette.dart';
import 'package:flutter/widgets.dart';

class GameBg extends StatelessWidget {
  const GameBg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BasicPalette.black.color,
    );
  }
}
