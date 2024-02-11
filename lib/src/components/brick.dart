import 'dart:async';
import 'dart:ui';

import 'package:brick_breaker/src/brick_breaker.dart';
import 'package:brick_breaker/src/components/ball.dart';
import 'package:brick_breaker/src/components/bat.dart';
import 'package:brick_breaker/src/config.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Brick extends RectangleComponent
    with CollisionCallbacks, HasGameRef<BrickBreaker> {
  Brick(Vector2 position, Color color)
      : super(
          position: position,
          anchor: Anchor.center,
          size: Vector2(gameWidth * 0.05, gameHeight * 0.05),
          paint: Paint()..color = color,
        );

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Ball) {
      removeFromParent();
    }

    super.onCollisionStart(intersectionPoints, other);
  }
}
