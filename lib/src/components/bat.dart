import 'dart:ui';

import 'package:brick_breaker/src/brick_breaker.dart';
import 'package:brick_breaker/src/config.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

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
    position.x = (position.x + event.localDelta.x)
        .clamp(width / 2, gameWidth - width / 2);
    super.onDragUpdate(event);
  }
}
