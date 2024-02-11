import 'package:brick_breaker/src/brick_breaker.dart';
import 'package:brick_breaker/src/components/bat.dart';
import 'package:brick_breaker/src/components/play_area.dart';
import 'package:brick_breaker/src/config.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Ball extends CircleComponent
    with CollisionCallbacks, HasGameRef<BrickBreaker> {
  Ball({
    required super.position,
    required double radius,
  }) : super(
            radius: radius,
            anchor: Anchor.topLeft,
            paint: Paint()
              ..color = const Color(0xff1e6091)
              ..style = PaintingStyle.fill);
  Vector2 velocity = Vector2.zero();
  double ballSpeed = 0.2;

  final rand = math.Random();
  @override
  Future<void> onLoad() {
    velocity = Vector2(ballSpeed * game.size.x, game.size.y * ballSpeed);
    add(CircleHitbox());
    priority = 2;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position += velocity * dt;
    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayArea) {
      if (intersectionPoints.first.y <= 8 && velocity.y < 0) {
        print('calledY<=0');

        velocity.y = -velocity.y;
      } else if (intersectionPoints.first.x <= 8 && velocity.x < 0) {
        print('calledX<=0');
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.x >= gameWidth - 8 &&
          velocity.x > 0) {
        print('called  X>=gameWidth');
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.y >= gameHeight - 8 &&
          velocity.y > 0) {
        print('called  Y>=gameHeight');

        add(RemoveEffect(
          delay: 0.35,
        ));
      } else {
        print('called  else');
        velocity = Vector2.zero();
      }
    } else if (other is Bat) {
      ballSpeed += 0.05;
      velocity = Vector2(velocity.x * 1.2, -velocity.y * 1.2);
      velocity.x = velocity.x +
          (position.x - other.position.x) / other.size.x * game.size.x * 0.3;
    }
  }
}
