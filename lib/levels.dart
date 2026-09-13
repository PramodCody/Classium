import 'package:flutter/material.dart';
import 'button1.dart';
//activate each after making a scene related to all those buttons.
// import 'button2.dart';
// import 'button3.dart';
// import 'button4.dart';
// import 'button5.dart';
// import 'button6.dart';
// import 'button7.dart';
// import 'button8.dart';
// import 'button9.dart';
// import 'button10.dart';

// Widget list corresponding to numbers 1–10
const List<Widget Function()> _destinations = [
  Button1.new,
  // Button2.new,
  // Button3.new,
  // Button4.new,
  // Button5.new,
  // Button6.new,
  // Button7.new,
  // Button8.new,
  // Button9.new,
  // Button10.new,
];

class LevelsScreen extends StatelessWidget {
  const LevelsScreen({super.key});

  static const Color _buttonColor = Color(0xFF3E7B3E);
  static const Color _appBarColor = Color(0xFF4A8C4A);

  ButtonStyle get _buttonStyle => ElevatedButton.styleFrom(
    backgroundColor: _buttonColor,
    foregroundColor: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    textStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3EB),
      appBar: AppBar(
        backgroundColor: _appBarColor,
        centerTitle: true,
        title: const Text(
          'Select Level',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2,
            children: List.generate(10, (index) {
              final number = index + 1;
              return ElevatedButton(
                style: _buttonStyle,

                //On Level Buttons Pressed
                onPressed: () {
                  if (index < _destinations.length) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _destinations[index](),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('This lesson is not available yet.'),
                      ),
                    );
                  }
                },

                child: Text('$number'),
              );
            }),
          ),
        ),
      ),
    );
  }
}
