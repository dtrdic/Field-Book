import 'package:flutter/material.dart';

class FieldBookIntroSlide extends StatelessWidget {
  const FieldBookIntroSlide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/field_book_intro_icon.png', height: 120),
        const SizedBox(height: 24),
        const Text(
          'Field Book',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
        ),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            'Field Book helps you collect and manage field data efficiently.',
            style: TextStyle(fontSize: 18, color: Color(0xFF212121)),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

