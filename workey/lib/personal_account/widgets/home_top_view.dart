
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:workey/general/models/shift_model.dart';

class HomeTopView extends StatefulWidget {

  final double constraintsMaxHeight;

  HomeTopView(this.constraintsMaxHeight);

  @override

  _HomeTopViewState createState() => _HomeTopViewState();
}

class _HomeTopViewState extends State<HomeTopView> {
  bool _isRunning = false;
  String _timer = "00:00:00";
  final duration = const Duration(seconds: 1);
  var _swatch = Stopwatch();
  int seconds;
  DateTime start;
  DateTime end;

  void timer() {
    seconds++;
    Timer(duration, keepRunning);
  }

  void keepRunning() {
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
    seconds = 0;
    start = DateTime.now();
    setState(() {
      _isRunning = true;
    });
    _swatch.start();
    timer();
  }

  void stopTimer() {
    setState(() {
      _isRunning = false;
    });
    _swatch.stop();
    _swatch.reset();
    end = DateTime.now();
    ShiftModel shiftModel = ShiftModel(
      startTime: start,
      endTime: end,
    );
  }

  Widget timerWidget() {
    return Positioned(
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
    );
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
          timerWidget(),

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
