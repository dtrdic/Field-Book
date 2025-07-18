import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'field_book_intro_slide.dart';
import 'gallery_slide.dart';
import 'required_setup_slide.dart';
import 'optional_setup_slide.dart';

class AppIntroActivity extends StatelessWidget {
  const AppIntroActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final introKey = GlobalKey<IntroductionScreenState>();
    final slides = [
      const FieldBookIntroSlide(),
      const GallerySlide(),
      RequiredSetupSlide(
        onContinue: () => introKey.currentState?.next(),
      ),
      const OptionalSetupSlide(),
    ];
    return IntroductionScreen(
      key: introKey,
      pages: slides
          .map((slide) => PageViewModel(
                titleWidget: const SizedBox.shrink(),
                bodyWidget: slide,
                decoration: const PageDecoration(
                  pageColor: Color(0x428BC34A),
                ),
              ))
          .toList(),
      showSkipButton: false,
      next: const Icon(Icons.arrow_forward, color: Color(0xFF689F38)),
      done: const Text('Done', style: TextStyle(color: Colors.black)),
      onDone: () => Navigator.of(context).pop(true),
      dotsDecorator: DotsDecorator(
        activeColor: const Color(0xFF689F38),
        color: const Color(0x428BC34A),
      ),
    );
  }
}
