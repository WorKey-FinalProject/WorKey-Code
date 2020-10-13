import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flip_card/flip_card.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/models/work_group_model.dart';
import 'package:workey/general/providers/auth.dart';
import 'package:workey/general/providers/company_groups.dart';
import 'package:workey/general/providers/shifts.dart';
import 'package:workey/helpers/location_helper.dart';

const String portName = "MyAppPort";

class HomeTopView extends StatefulWidget {
  final double constraintsMaxHeight;

  HomeTopView(this.constraintsMaxHeight);

  @override
  _HomeTopViewState createState() => _HomeTopViewState();
}

startAlarm() async {
  await AndroidAlarmManager.periodic(Duration(seconds: 1), 0, timerCallback,
      wakeup: true, exact: true);
}

timerCallback() {
  SendPort sendPort = IsolateNameServer.lookupPortByName(portName);
  if (sendPort != null) {
    sendPort.send("DONE");
  }
}

class _HomeTopViewState extends State<HomeTopView> {
  var _isInRange = false;

  var _isLoading = false;
  LocationData _currentLocation;
  WorkGroupModel _workGroup;

  ReceivePort receivePort = ReceivePort();
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
    IsolateNameServer.registerPortWithName(receivePort.sendPort, portName);
    AndroidAlarmManager.initialize();
    receivePort.listen((v) {
      print(v);
    });
  }

  Future<void> _getCurrentUserLocation() async {
    setState(() {
      _isLoading = true;
    });
    final locData = await Location().getLocation();
    setState(() {
      _currentLocation = locData;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _workGroup = Provider.of<CompanyGroups>(context).getCurrentWorkGroup;

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
                child: InkWell(
                  onTap: () async {
                    await _getCurrentUserLocation();
                    var _distanceInMeters =
                        GeolocatorPlatform.instance.distanceBetween(
                      _workGroup.location.latitude,
                      _workGroup.location.longitude,
                      _currentLocation.latitude,
                      _currentLocation.longitude,
                    );
                    print('$_distanceInMeters--- distance');
                    if (_distanceInMeters > 100) {
                      setState(() {
                        _isInRange = false;
                      });
                    } else {
                      setState(() {
                        _isInRange = true;
                      });
                    }
                  },
                  child: !_isInRange
                      ? Center(
                          child: _isLoading
                              ? CircularProgressIndicator()
                              : Icon(
                                  Icons.location_on,
                                  color: Theme.of(context).secondaryHeaderColor,
                                  size: 50,
                                ),
                        )
                      : FlipCard(
                          flipOnTouch: true,
                          onFlip: () async {
                            // await _getCurrentUserLocation();
                            // var _distanceInMeters =
                            //     GeolocatorPlatform.instance.distanceBetween(
                            //   _workGroup.location.latitude,
                            //   _workGroup.location.longitude,
                            //   _currentLocation.latitude,
                            //   _currentLocation.longitude,
                            // );
                            // print('$_distanceInMeters--- distance');
                            // if (_distanceInMeters > 100) {
                            //   Fluttertoast.showToast(
                            //       msg: 'You are not in work range');
                            // } else {
                            startAlarm();
                            dynamic p =
                                await Provider.of<Auth>(context, listen: false)
                                    .getCurrUserData();
                            if (!_isRunning) {
                              _seconds = 0;
                              _start = DateTime.now();
                              Provider.of<CompanyGroups>(context, listen: false)
                                  .setIsWorkingForPersonal(true, p.companyId);
                              startTimer();
                            } else if (_isRunning) {
                              Provider.of<CompanyGroups>(context, listen: false)
                                  .setIsWorkingForPersonal(false, p.companyId);
                              stopTimer();
                            }
                          },
                          //},
                          front: Center(
                            child: Icon(
                              MdiIcons.locationEnter,
                              color: Theme.of(context).secondaryHeaderColor,
                              size: 50,
                            ),
                          ),
                          back: Center(
                            child: Text(
                              _timer,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
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
