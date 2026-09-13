import 'package:flutter/material.dart';

class DrawingBoard extends StatefulWidget {
  const DrawingBoard({super.key});

  @override
  State<DrawingBoard> createState() => _DrawingBoardState();
}

class _DrawingBoardState extends State<DrawingBoard> {
  static const Color _appBarColor = Color(0xFF4A8C4A);
  static const Color _buttonColor = Color(0xFF3E7B3E);

  static const int _gridCount = 6;

  // Each grid holds its own list of strokes; each stroke is a list of points.
  final List<List<List<Offset>>> _gridStrokes = List.generate(
    _gridCount,
    (_) => [],
  );

  bool _clearMode = false;

  ButtonStyle get _actionButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: _buttonColor,
    foregroundColor: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );

  void _handleGridTap(int index) {
    if (_clearMode) {
      setState(() {
        _gridStrokes[index].clear();
        _clearMode = false;
      });
    }
  }

  void _onPanStart(int index, DragStartDetails details) {
    if (_clearMode) return;
    setState(() {
      _gridStrokes[index].add([details.localPosition]);
    });
  }

  void _onPanUpdate(int index, DragUpdateDetails details) {
    if (_clearMode) return;
    setState(() {
      _gridStrokes[index].last.add(details.localPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3EB),
      appBar: AppBar(
        backgroundColor: _appBarColor,
        centerTitle: true,
        title: const Text(
          '0',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_clearMode)
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  'Tap a grid to clear it',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            Expanded(
              child: Column(
                children: List.generate(3, (rowIndex) {
                  return Expanded(
                    child: Row(
                      children: List.generate(2, (colIndex) {
                        final index = rowIndex * 2 + colIndex;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: GestureDetector(
                              onTap: () => _handleGridTap(index),
                              onPanStart: (details) =>
                                  _onPanStart(index, details),
                              onPanUpdate: (details) =>
                                  _onPanUpdate(index, details),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                                child: CustomPaint(
                                  painter: _GridPainter(_gridStrokes[index]),
                                  child: Container(),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: _actionButtonStyle,
                  onPressed: () {
                    setState(() {
                      _clearMode = !_clearMode;
                    });
                  },
                  child: Text(_clearMode ? 'Cancel' : 'Clear'),
                ),
                ElevatedButton(
                  style: _actionButtonStyle,
                  onPressed: () {},
                  child: const Text('Save'),
                ),
                ElevatedButton(
                  style: _actionButtonStyle,
                  onPressed: () {},
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final List<List<Offset>> strokes;

  _GridPainter(this.strokes);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    for (final stroke in strokes) {
      for (int i = 0; i < stroke.length - 1; i++) {
        canvas.drawLine(stroke[i], stroke[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) => true;
}
