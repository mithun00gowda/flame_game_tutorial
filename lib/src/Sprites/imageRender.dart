import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

class Imagerender extends FlameGame {
  @override
  FutureOr<void> onLoad() async {
    await images.load("background.jpg");
    await images.load("player_blue_on0.png");
    add(SpriteBackground());
    add(PlayerSprite());
  }
}

class PlayerSprite extends SpriteComponent with HasGameRef {
  @override
  FutureOr<void> onLoad() async {
    sprite = await gameRef.loadSprite('player_blue_on0.png');

    size = Vector2(100, 100);
    position = Vector2(100, 200);
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    position.y += 10 * dt;
  }
}

class SpriteBackground extends SpriteComponent with HasGameRef {
  @override
  FutureOr<void> onLoad() async {
    sprite = await gameRef.loadSprite('background.jpg');
    size = Vector2(500, 500);
    position = Vector2(0, 0);
    anchor = Anchor.topLeft;
  }
}
