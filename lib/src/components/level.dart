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

import 'package:flutter/services.dart';

enum PlayState {
  welcome,
  playing,
  gameOver,
  won,
}

class Level extends World with HasGameRef<BrickBreaker>, KeyboardHandler {
  Level();

  final rand = math.Random();
  final bat = Bat(
    cornerRadius: const Radius.circular(batHeight / 2),
    position: Vector2(
      gameWidth / 2,
      gameHeight - batHeight,
    ),
    size: Vector2(batWidth, batHeight),
  );
  late PlayState _playState; // Add from here...
  PlayState get playState => _playState;
  set playState(PlayState playState) {
    _playState = playState;
    switch (playState) {
      case PlayState.welcome:
      case PlayState.gameOver:
      case PlayState.won:
        game.overlays.add(playState.name);

      case PlayState.playing:
        game.overlays.remove(PlayState.welcome.name);
        game.overlays.remove(PlayState.gameOver.name);
        game.overlays.remove(PlayState.won.name);
    }
  }

  @override
  FutureOr<void> onLoad() async {
    playState = PlayState.welcome;
    final playArea = PlayArea();
    add(playArea);
    return super.onLoad();
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      bat.horizontalMovement = -1;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      bat.horizontalMovement = 1;
    }

    return super.onKeyEvent(event, keysPressed);
  }

  void startGame() async {
    if (playState == PlayState.playing) return;

    // remove all children
    removeAll(game.level.children.query<Bat>());
    removeAll(game.level.children.query<Ball>());
    removeAll(game.level.children.query<Brick>());
    playState = PlayState.playing;
    final ball = Ball(
      radius: ballRadius,
      position: Vector2(gameWidth / 2, gameHeight - batHeight - 20),
    );

    await addAll(
      [
        bat,
        ball,
        for (var i = 0; i < numberOfBricksColumns; i++)
          for (var j = 0; j <= numberOfBrickRows; j++)
            Brick(
              Vector2(
                (i * 30) + (i * 2) + 5,
                (j * 30) + (j * 2) + 5,
              ),
              brickColors[i % brickColors.length],
            ),
      ],
    );
  }
}
