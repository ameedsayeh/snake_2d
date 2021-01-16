import 'package:flutter/material.dart';
import 'package:snake_game/canvas_size.dart';

import 'game_canvas.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: SafeArea(
          child: GameCanvas(),
        ),
      ),
    );
  }
}
