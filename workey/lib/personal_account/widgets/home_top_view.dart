import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/models/shift_model.dart';
import 'package:workey/general/providers/shifts.dart';

class HomeTopView extends StatefulWidget {
  final double constraintsMaxHeight;

  HomeTopView(this.constraintsMaxHeight);

  @override
  _HomeTopViewState createState() => _HomeTopViewState();
}

class _HomeTopViewState extends State<HomeTopView> {
  bool _isRunning = false;
  String _timer = "00:00:00";
  final _duration = const Duration(seconds: 1);
  var _swatch = Stopwatch();
  int _seconds;
  DateTime _start;
  DateTime _end;

  void timer() {
    Timer(_duration, keepRunning);
  }

  void keepRunning() {
    _seconds++;
    if (_swatch.isRunning) {
      startTimer();
    }
    setState(() {
      _timer = _swatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (_swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (_swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  void startTimer() {
    setState(() {
      _isRunning = true;
    });
    _swatch.start();
    timer();
  }

  void stopTimer() async {
    setState(() {
      _isRunning = false;
    });
    _swatch.stop();
    _swatch.reset();
    _end = DateTime.now();
    await Provider.of<Shifts>(context, listen: false)
        .addShiftToFirebaseAndList(_start, _end, _seconds);
  }

  @override
  void initState() {
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(
      onMessage: (message) {
        print(message);
        return;
      },
      onLaunch: (message) {
        print(message);
        return;
      },
      onResume: (message) {
        print(message);
        return;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.constraintsMaxHeight,
      child: Stack(
        children: <Widget>[
          Container(
            height: widget.constraintsMaxHeight * 0.75,

            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: 56,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: Theme.of(context).primaryColor.withOpacity(0.23),
                ),
              ],
            ),

            // child: Center(
            //   child:
            //       IconButton(icon: Icon(MdiIcons.faceRecognition), onPressed: null),
            //   // child: GestureDetector(
            //   //   onTap: () => null,
            //   //   child: Icon(
            //   //     MdiIcons.faceRecognition,
            //   //     color: Colors.white,
            //   //     size: 70,
            //   //   ),
            //   // ),Icon
            // ),
          ),
          Positioned(
            top: 5,
            right: 0,
            left: 0,
            child: Center(
              child: Text(
                _timer,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -10,
            left: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              maxRadius: 60,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                maxRadius: 50,
                child: IconButton(
                  icon: Icon(MdiIcons.faceRecognition),
                  onPressed: () {
                    if (!_isRunning) {
                      _seconds = 0;
                      _start = DateTime.now();
                      startTimer();
                    } else if (_isRunning) {
                      stopTimer();
                    }
                  },
                  iconSize: 40,
                ),
              ),
            ),
          ),
        ],
        overflow: Overflow.visible,
      ),
    );
  }
}
