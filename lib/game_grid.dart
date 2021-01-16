import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snake_game/canvas_size.dart';

class GameGrid extends StatefulWidget {
  final CanvasSize gridSize;

  const GameGrid({Key key, this.gridSize}) : super(key: key);

  @override
  _GameGridState createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> {
  int _xValue = 0;
  int _yValue = 0;
  AxisDirection _direction = AxisDirection.down;

  Size calculateCellSize(context) {
    return Size.square(
      (MediaQuery.of(context).size.width - 2 * 16.0) / widget.gridSize.width,
    );
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        switch (_direction) {
          case AxisDirection.up:
            _yValue -= 1;
            break;
          case AxisDirection.down:
            _yValue += 1;
            break;
          case AxisDirection.right:
            _xValue += 1;
            break;
          case AxisDirection.left:
            _xValue -= 1;
            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final cellSize = this.calculateCellSize(context);

    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            widget.gridSize.height,
            (r) => Row(
                  children: List.generate(
                    widget.gridSize.width,
                    (c) => renderCell(r, c, cellSize),
                  ),
                )),
      ),
    );
  }

  Widget renderCell(int r, int c, Size size) {
    if (c == _xValue && r == _yValue) {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.black87.withAlpha(40),
            ),
            color: Colors.black),
        width: size.width,
        height: size.height,
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.black87.withAlpha(40),
          ),
        ),
        width: size.width,
        height: size.height,
      );
    }
  }
}
