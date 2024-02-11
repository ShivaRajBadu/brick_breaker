import 'dart:async';
import 'dart:ui';

import 'package:brick_breaker/src/brick_breaker.dart';
import 'package:brick_breaker/src/components/ball.dart';
import 'package:brick_breaker/src/components/bat.dart';
import 'package:brick_breaker/src/components/brick.dart';
import 'package:brick_breaker/src/components/play_area.dart';
import 'package:brick_breaker/src/config.dart';
import 'package:flame/components.dart';
import 'dart:math' as math;

class Level extends World with HasGameRef<BrickBreaker> {
  Level();

  final rand = math.Random();

  @override
  FutureOr<void> onLoad() async {
    final playArea = PlayArea();
    final ball = Ball(
      radius: ballRadius,
      position: Vector2(gameWidth / 2, gameHeight - batHeight - 20),
    );
    final bat = Bat(
      cornerRadius: const Radius.circular(batHeight / 2),
      position: Vector2(
        gameWidth / 2,
        gameHeight - batHeight,
      ),
      size: Vector2(batWidth, batHeight),
    );

    await addAll([
      for (var i = 0; i < brickColors.length; i++)
        for (var j = 1; j <= 5; j++)
          Brick(
            Vector2(
              (i + 0.5) * brickWidth + (i + 1) * brickGutter,
              (j + 2.0) * brickHeight + j * brickGutter,
            ),
            brickColors[i],
          ),
    ]);

    await addAll([
      playArea,
      ball,
      bat,
      for (var i = 0; i < brickColors.length; i++)
        for (var j = 1; j <= 5; j++)
          Brick(
            Vector2(
              (i + 0.5) * brickWidth + (i + 1) * brickGutter,
              (j + 2.0) * brickHeight + j * brickGutter,
            ),
            brickColors[i],
          ),
    ]);

    return super.onLoad();
  }
}
