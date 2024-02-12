import 'dart:async';
import 'dart:ui';

import 'package:brick_breaker/src/brick_breaker.dart';
import 'package:brick_breaker/src/components/ball.dart';
import 'package:brick_breaker/src/components/level.dart';
import 'package:brick_breaker/src/config.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Brick extends RectangleComponent
    with CollisionCallbacks, HasGameRef<BrickBreaker> {
  Brick(Vector2 position, Color color)
      : super(
          position: position,
          anchor: Anchor.center,
          size: Vector2(brickWidth, brickHeight),
          paint: Paint()..color = color,
        );

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());
    // debugMode = true;
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Ball) {
      removeFromParent();
      if (game.level.children.query<Brick>().length == 1) {
        game.level.playState = PlayState.won;
        game.level.removeAll(game.level.children);
      }

      // if (children.query<Brick>()) {
      //   print('wonnnnnnnnnnnnnnnnn');
      //   game.world.removeAll(game.world.children.query<Ball>());
      //   game.world.removeAll(game.world.children.query<Bat>());
      // }
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  load() {}
}
