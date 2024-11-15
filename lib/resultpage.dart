import 'dart:async';
import 'dart:math';
import 'package:euphoria/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class ResultPage extends StatefulWidget {
  final int score;

  const ResultPage(this.score, {super.key});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final ConfettiController _controller = ConfettiController();

  @override
  void initState() {
    super.initState();
    // Start confetti animation when the widget is initialized
    _controller.play();
    // Delay navigation to another page after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MainPage(
                  score: widget.score,
                )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    String message;
    Color messageColor;

    if (widget.score >= 40 && widget.score <= 50) {
      message = 'Very Positive';
      messageColor = Colors.green.shade900;
    } else if (widget.score >= 30 && widget.score <= 40) {
      message = 'Moderately positive';
      //messageColor = Colors.orange.shade700;
      messageColor = Colors.green.shade500;
    } else if (widget.score >= 20 && widget.score <= 30) {
      message = 'Neutral';
      //messageColor = Colors.orange.shade700;
      messageColor = Colors.green.shade200;
    } else if (widget.score >= 10 && widget.score <= 20) {
      message = 'Moderately negative';
      messageColor = Colors.orange.shade700;
      //messageColor = Colors.green.shade200;
    } else {
      message = 'Very negative';
      messageColor = Colors.red.shade900;
    }

    return Scaffold(
      backgroundColor: Colors.blue.shade500,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your Score: ${widget.score}',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              message,
              style: TextStyle(fontSize: 20, color: messageColor),
            ),
            // ConfettiWidget(
            //   confettiController: _controller,
            //   blastDirection: -pi / 2,
            //   particleDrag: 0.05,
            //   emissionFrequency: 0.02,
            //   numberOfParticles: 20,
            //   gravity: 0.05,
            // )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the confetti controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }
}
