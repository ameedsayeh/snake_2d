import 'package:flutter/material.dart';
import 'package:snake_game/canvas_size.dart';
import 'package:snake_game/game_grid.dart';

class GameCanvas extends StatefulWidget {
  @override
  _GameCanvasState createState() => _GameCanvasState();
}

class _GameCanvasState extends State<GameCanvas> {
  GlobalKey<GameGridState> _gameGridKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: FloatingActionButton(
              onPressed: () {
                _gameGridKey.currentState.startGame();
              },
              backgroundColor: Colors.greenAccent.shade400,
              child: Icon(Icons.play_arrow),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Center(
            child: GameGrid(
              key: _gameGridKey,
              gridSize: CanvasSize(
                20,
                20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
