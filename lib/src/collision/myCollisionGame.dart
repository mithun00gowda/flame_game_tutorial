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
  late TextComponent scoreText;
  int score = 0;

  @override
  Future<void> onLoad() async {
    // Add the coin
    scoreText = TextComponent(
      text: 'Score: 0',
      position: Vector2(20, 50),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    add(scoreText);
    add(Coin(position: Vector2(200, 400)));

    // Add the player
    add(Player(position: Vector2(200, 100)));
  }

  void incrementScore() {
    score++;
    scoreText.text = 'Score: $score';
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

    // --- LEFT WALL ---
    if (position.x < 0) {
      position.x = 0;
      velocity.x = -velocity.x;
    }

    // --- RIGHT WALL ---
    // gameRef.size.x is the width of the screen
    // size.x is the width of the player (50)
    if (position.x > gameRef.size.x - size.x) {
      position.x = gameRef.size.x - size.x;
      velocity.x = -velocity.x; // Bounce back
    }

    // --- CEILING (Top) ---
    if (position.y < 0) {
      position.y = 0;
      velocity.y = -velocity.y; // Bounce down
    }

    // --- FLOOR (Bottom) ---
    if (position.y > gameRef.size.y - size.y) {
      position.y = gameRef.size.y - size.y;
      velocity.y = -velocity.y; // Bounce back up
    }
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
      gameRef.incrementScore();
      print("Score: ${gameRef.score}");
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    // Reverse horizontal direction
    velocity.y = -200;
  }
}
