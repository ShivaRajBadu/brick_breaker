import 'dart:ui';

import 'package:brick_breaker/src/brick_breaker.dart';
import 'package:brick_breaker/src/config.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/widgets.dart';

class Bat extends PositionComponent
    with DragCallbacks, HasGameRef<BrickBreaker> {
  Bat({
    required this.cornerRadius,
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.center,
          children: [RectangleHitbox()],
        );
  final Radius cornerRadius;
  final _paint = Paint()
    ..color = const Color(0xff1e6091)
    ..style = PaintingStyle.fill;
  Vector2 velocity = Vector2.zero();
  double batSpeed = 400;
  double horizontalMovement = 0;
  @override
  void render(Canvas canvas) {
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size.toSize(),
          cornerRadius,
        ),
        _paint);
    super.render(canvas);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    horizontalMovement = 0;
    _updatePosition(event);
    super.onDragUpdate(event);
  }

  @override
  void update(double dt) {
    velocity.x = horizontalMovement * batSpeed;
    // clamp position between batWidth and gameWidth - batWidth
    position.x = position.x.clamp(batWidth / 2, gameWidth - batWidth / 2);

    position += velocity * dt;

    super.update(dt);
  }

  void _updatePosition(DragUpdateEvent event) {
    if (event.localDelta.x < 0 && horizontalMovement != -1) {
      horizontalMovement = -1;
    } else if (event.localDelta.x > 0 && horizontalMovement != 1) {
      horizontalMovement = 1;
    } else {
      horizontalMovement = 0;
    }
  }
}
