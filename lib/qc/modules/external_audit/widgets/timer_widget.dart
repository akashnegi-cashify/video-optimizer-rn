import 'dart:async';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final int totalTimeInSeconds;
  final Function onTimerEnd;

  const TimerWidget(this.totalTimeInSeconds, {required this.onTimerEnd, super.key});

  @override
  State<TimerWidget> createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget> {
  late int _remainingTimeInSeconds;
  Timer? _videoRecorderTimer;

  String _getTimeString(int seconds) {
    String res = "";

    int mins = seconds ~/ 60;
    int secs = seconds % 60;

    if (mins < 10) {
      res += "0$mins";
    } else {
      res += "$mins";
    }

    if (secs < 10) {
      res += ":0$secs";
    } else {
      res += ":$secs";
    }
    return res;
  }

  void startTimer() {
    _videoRecorderTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTimeInSeconds--;
        if (_remainingTimeInSeconds == 0) {
          widget.onTimerEnd();
          timer.cancel();
        }
      });
    });
  }

  void reset() {
    _remainingTimeInSeconds = widget.totalTimeInSeconds;
    if (_videoRecorderTimer?.isActive == true) {
      _videoRecorderTimer?.cancel();
    }
    _videoRecorderTimer == null;
  }

  @override
  void initState() {
    super.initState();
    _remainingTimeInSeconds = widget.totalTimeInSeconds;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Text(
      _getTimeString(_remainingTimeInSeconds),
      style: theme.primaryTextTheme.displayMedium?.copyWith(color: theme.colorScheme.error),
    );
  }

  @override
  void dispose() {
    if (_videoRecorderTimer?.isActive == true) {
      _videoRecorderTimer?.cancel();
    }
    super.dispose();
  }
}