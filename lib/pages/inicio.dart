import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:exp_app/main.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MyCustomWidgetState extends StatefulWidget {
  const MyCustomWidgetState({Key? key}) : super(key: key);

  @override
  State<MyCustomWidgetState> createState() => _MyCustomWidgetStateState();
}

class _MyCustomWidgetStateState extends State<MyCustomWidgetState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
                'Supongamos que esta es una aplicación en la página de inicio de su teléfono',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            OpenContainer(
                closedBuilder: (_, openContainer) {
                  return const SizedBox(
                    height: 80,
                    width: 80,
                    child: Text(
                      'FINANCES',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
                openColor: const Color(0xff412EEF),
                closedElevation: 20,
                closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                transitionDuration: const Duration(milliseconds: 700),
                openBuilder: (_, closeContainer) {
                  return SecondClass();
                })
          ],
        ),
      ),
    );
  }
}

class SecondClass extends StatefulWidget {
  const SecondClass({Key? key}) : super(key: key);

  State<SecondClass> createState() => _SecondClassState();
}

class _SecondClassState extends State<SecondClass>
    with TickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  @override
  initState() {
    super.initState();

    scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.of(context).pushReplacement(
            PageTransition(
              child: MyApp(),
              type: PageTransitionType.bottomToTop,
            ),
          );
          Timer(
            const Duration(milliseconds: 300),
            () {
              scaleController.reset();
            },
          );
        }
      });

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(scaleController);

    Timer(const Duration(seconds: 2), () {
      setState(() {
        scaleController.forward();
      });
    });
  }

  @override
  void dispose() {
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff412EEF),
      body: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              'FINANCES',
              speed: const Duration(milliseconds: 150),
            ),
          ],
          isRepeatingAnimation: false,
          repeatForever: false,
          displayFullTextOnTap: false,
        ),
      ),
    );
  }
}
