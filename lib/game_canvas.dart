import 'package:flutter/material.dart';
import 'package:snake_game/canvas_size.dart';
import 'package:snake_game/game_grid.dart';

class GameCanvas extends StatefulWidget {
  @override
  _GameCanvasState createState() => _GameCanvasState();
}

class _GameCanvasState extends State<GameCanvas> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: GameGrid(
          gridSize: CanvasSize(20, 20),
        ),
      ),
    );
  }
}
