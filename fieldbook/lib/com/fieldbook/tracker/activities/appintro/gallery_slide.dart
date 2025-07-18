import 'package:flutter/material.dart';

class GallerySlide extends StatelessWidget {
  const GallerySlide({Key? key}) : super(key: key);

  final List<String> images = const [
    'assets/images/field_book_mini_numeric.png',
    'assets/images/field_book_mini_categorical.png',
    'assets/images/field_book_mini_percent.png',
    'assets/images/field_book_intro_brapi.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Features and Customization',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
        ),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            'Data is entered into Field Book with custom trait layouts that are designed to simplify data input and minimize mistakes.\n\n By default, collected data is stored locally, but Field Book supports the Breeding API which allows it to send data to BrAPI-compatible systems.',
            style: TextStyle(fontSize: 18, color: Color(0xFF212121)),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: images.map((img) => Image.asset(img, height: 80)).toList(),
          ),
        ),
      ],
    );
  }
}
