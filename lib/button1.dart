import 'package:flutter/material.dart';



class Button1 extends StatelessWidget {
  const Button1({super.key});

  static const Color _buttonColor = Color(0xFF3E7B3E);
  static const Color _appBarColor = Color(0xFF4A8C4A);

  ButtonStyle get _buttonStyle => ElevatedButton.styleFrom(
        backgroundColor: _buttonColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3EB),
      appBar: AppBar(
        backgroundColor: _appBarColor,
        centerTitle: true,
        title: const Text(
          'Select Lesson',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),

      
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2,
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2.2,
            children: [
              ElevatedButton(
                style: _buttonStyle,
                onPressed: () {},
                child: const Text('0'),
              ),
              ElevatedButton(
                style: _buttonStyle,
                onPressed: () {},
                child: const Text('|'),
              ),
              ElevatedButton(
                style: _buttonStyle,
                onPressed: () {},
                child: const Text('C'),
              ),
              ElevatedButton(
                style: _buttonStyle,
                onPressed: () {},
                child: const Text('S'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}