import 'package:brick_breaker/src/brick_breaker.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const GameWidget.controlled(
    gameFactory: BrickBreaker.new,
  ));
}
