import 'package:flutter/material.dart';

class PreviousNextButton extends StatelessWidget {
  final int currentStep;
  final Function changeStep;

  const PreviousNextButton({
    Key key,
    this.currentStep,
    this.changeStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 3,
        left: 8,
        right: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlatButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                ),
                Text(
                  'Prevoius',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: Row(
              children: [
                Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
