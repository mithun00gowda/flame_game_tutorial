import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

// class Myfirstgame extends FlameGame {
//   @override
//   Future<void> onLoad() async {
//     add(RedBoxPlayer());
//   }
// }

// class RedBoxPlayer extends PositionComponent {
//   @override
//   Future<void> onLoad() async {
//     size = Vector2(10, 10);
//     position = Vector2(100, 100);
//     anchor = Anchor.center;
//   }

//   @override
//   void update(double dt) {
//     // position.x += 100 * dt;
//     position.x += 100 * dt;

//     if (position.x > 500) {
//       position.x = 0;
//     }
//   }

//   @override
//   void render(Canvas canvas) {
//     canvas.drawRect(size.toRect(), Paint()..color = Colors.blue);
//   }
// }

class Myfirstgame extends FlameGame {
  @override
  FutureOr<void> onLoad() {
    add(RedBoxPlayer());
  }
}

class RedBoxPlayer extends PositionComponent with TapCallbacks {
  Color boxColor = Colors.red;
  double speed = 100;
  @override
  FutureOr<void> onLoad() {
    size = Vector2(50, 50);
    position = Vector2(100, 100);
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    position.x += speed * dt;
    if (position.x > 500 || position.x < 0) {
      position.x = 0;
    }
    angle += 2 * dt;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), Paint()..color = boxColor);
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (boxColor == Colors.red) {
      boxColor = Colors.blue;
    } else {
      boxColor = Colors.red;
    }
    print("Box tapped");
    speed *= -1;
  }
}
