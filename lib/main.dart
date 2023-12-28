import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: CountdownApp(),
    ),
  );
}

class CountdownApp extends StatefulWidget {
  @override
  _CountdownAppState createState() => _CountdownAppState();
}

class _CountdownAppState extends State<CountdownApp> {
  late Duration _duration;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    DateTime targetDate = DateTime(2024, 1, 1);
    DateTime currentDate = DateTime.now();
    _duration = targetDate.difference(currentDate);
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          if (_duration.inSeconds == 0) {
            timer.cancel();
          } else {
            _duration = _duration - oneSec;
          }
        });
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    return '${duration.inDays} days\n${duration.inHours % 24} hours\n${duration.inMinutes % 60} minutes\n${duration.inSeconds % 60} seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text(
          "Countdown to 2024",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            _formatDuration(_duration),
            style: TextStyle(
              fontSize: 60,
              fontFamily: 'Dottles',
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
