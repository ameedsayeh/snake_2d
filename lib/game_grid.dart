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
  bool _canUpdateDirection = true;
  int _snakeLength = 5;
  AxisDirection _direction = AxisDirection.down;

  List<List<int>> _gridHistory;
  Timer _timer;
  bool _isLost = false;

  Size calculateCellSize(context) {
    return Size.square(
      (MediaQuery.of(context).size.width - 2 * 16.0) / widget.gridSize.width,
    );
  }

  _directionUpdate(details) {
    if (!_canUpdateDirection) {
      return;
    }
    if (details.delta.dx > 10 && _direction != AxisDirection.left) {
      _direction = AxisDirection.right;
      _canUpdateDirection = false;
    } else if (details.delta.dx < -10 && _direction != AxisDirection.right) {
      _direction = AxisDirection.left;
      _canUpdateDirection = false;
    } else if (details.delta.dy > 10 && _direction != AxisDirection.up) {
      _direction = AxisDirection.down;
      _canUpdateDirection = false;
    } else if (details.delta.dy < -10 && _direction != AxisDirection.down) {
      _direction = AxisDirection.up;
      _canUpdateDirection = false;
    }
  }

  _generateGridHistory() {
    this._gridHistory = List.generate(widget.gridSize.height,
        (r) => List<int>.generate(widget.gridSize.width, (c) => 0));
  }

  @override
  void initState() {
    super.initState();

    _generateGridHistory();

    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      switch (_direction) {
        case AxisDirection.up:
          if (_yValue > 0) {
            _yValue -= 1;
          } else {
            _isLost = true;
            _timer.cancel();
          }
          break;
        case AxisDirection.down:
          if (_yValue < widget.gridSize.height - 1) {
            _yValue += 1;
          } else {
            _isLost = true;
            _timer.cancel();
          }
          break;
        case AxisDirection.right:
          if (_xValue < widget.gridSize.width - 1) {
            _xValue += 1;
          } else {
            _isLost = true;
            _timer.cancel();
          }
          break;
        case AxisDirection.left:
          if (_xValue > 0) {
            _xValue -= 1;
          } else {
            _isLost = true;
            _timer.cancel();
          }
          break;
      }
      _canUpdateDirection = true;

      if (_gridHistory[_yValue][_xValue] > 0 && !_isLost) {
        // lose state
        _isLost = true;
        _timer.cancel();
      } else if (!_isLost) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cellSize = this.calculateCellSize(context);

    return GestureDetector(
      onPanUpdate: _directionUpdate,
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
      _gridHistory[r][c] = _snakeLength - 1;

      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.black87.withAlpha(40),
          ),
          color: _isLost ? Colors.red : Colors.black,
        ),
        width: size.width,
        height: size.height,
      );
    } else if (_gridHistory[r][c] > 0) {
      if (!_isLost) {
        _gridHistory[r][c] -= 1;
      }
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.black87.withAlpha(40),
          ),
          color: Colors.black,
        ),
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
