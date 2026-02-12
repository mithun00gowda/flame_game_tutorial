import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class FirstBox extends FlameGame {
  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    add(Tapbox());
  }
}

class Tapbox extends PositionComponent with TapCallbacks {
  Color boxColor = Colors.blue;

  @override
  FutureOr<void> onLoad() {
    size = Vector2(50, 50);
    position = Vector2(100, 100);
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
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
  }
}
