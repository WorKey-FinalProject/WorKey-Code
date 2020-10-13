import 'package:flutter/material.dart';

class MonthlySummary extends StatelessWidget {
  final Color backgroundColor;
  final Text buttonText;
  final Color iconColor;
  final Alignment iconAlignment;

  MonthlySummary({
    this.backgroundColor = Colors.redAccent,
    this.buttonText = const Text("REQUIRED TEXT"),
    this.iconColor,
    this.iconAlignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[50],
      child: FlatButton(
        onPressed: () {
          var _isExpanded = false;
          var _height = MediaQuery.of(context).size.height * 0.4;

          showModalBottomSheet(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            context: context,
            builder: (_) {
              return StatefulBuilder(
                builder: (context, setLocationModalState) {
                  return GestureDetector(
                    onTap: () {
                      setLocationModalState(() {
                        _isExpanded = !_isExpanded;
                        if (_isExpanded) {
                          _height = MediaQuery.of(context).size.height;
                        } else {
                          _height = MediaQuery.of(context).size.height * 0.6;
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.fastOutSlowIn,
                      height: _height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                      ),
                      child: Text('ddd'),
                    ),
                  );
                },
              );
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: backgroundColor,
          ),
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          padding: const EdgeInsets.only(left: 10.0, right: 20.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
                      child: buttonText,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 60,
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Icon(Icons.data_usage_rounded),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}