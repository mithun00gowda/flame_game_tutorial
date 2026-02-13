import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: MyCollisionGame()));
}

class MyCollisionGame extends FlameGame with HasCollisionDetection {
  // GLOBAL VARIABLE: We keep the score here so the whole game can see it
  int score = 0;

  @override
  Future<void> onLoad() async {
    // Add the coin
    add(Coin(position: Vector2(200, 400)));

    // Add the player
    add(Player(position: Vector2(200, 100)));
  }
}

class Coin extends PositionComponent with CollisionCallbacks {
  Coin({required Vector2 position})
    : super(position: position, size: Vector2(50, 50));

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), Paint()..color = Colors.yellow);
  }
}

class Player extends PositionComponent
    with CollisionCallbacks, TapCallbacks, HasGameRef<MyCollisionGame> {
  // Give it X and Y speed. (Moving right and down)
  Vector2 velocity = Vector2(100, 100);

  Player({required Vector2 position})
    : super(position: position, size: Vector2(50, 50));

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position += velocity * dt;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), Paint()..color = Colors.red);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Coin) {
      other.removeFromParent();

      // Access the score variable in the main game class
      gameRef.score++;
      print("Score: ${gameRef.score}");
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    // Reverse horizontal direction
    velocity.x *= -1;
  }
}
