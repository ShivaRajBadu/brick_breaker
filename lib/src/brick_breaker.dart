import 'dart:async';
import 'dart:ui';
import 'package:brick_breaker/src/components/level.dart';
import 'package:brick_breaker/src/config.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class BrickBreaker extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents, TapDetector {
  BrickBreaker();

  late CameraComponent cam;
  Level level = Level();
  @override
  Color backgroundColor() {
    return const Color(0xFF211f30);
  }

  @override
  FutureOr<void> onLoad() {
    cam = CameraComponent.withFixedResolution(
      world: level,
      width: gameWidth,
      height: gameHeight,
    );
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, level]);

    return super.onLoad();
  }

  @override
  void onTap() {
    level.startGame();
    super.onTap();
  }
}
