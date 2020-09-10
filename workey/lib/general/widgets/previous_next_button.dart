import 'package:flutter/material.dart';

class PreviousNextButton extends StatefulWidget {
  final void Function(
    int step,
  ) changeStep;

  int currStep = 0;
  int maxStep = 0;
  GlobalKey<FormState> formKey;

  PreviousNextButton({
    this.changeStep,
    this.currStep,
    this.maxStep,
    this.formKey,
  });

  @override
  _PreviousNextButtonState createState() => _PreviousNextButtonState();
}

class _PreviousNextButtonState extends State<PreviousNextButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 3,
        left: 8,
        right: 8,
      ),
      child: widget.currStep > widget.maxStep
          ? Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: CircularProgressIndicator(),
            )
          : Row(
              mainAxisAlignment: widget.currStep > 0
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.end,
              children: [
                if (widget.currStep > 0)
                  FlatButton(
                    onPressed: () {
                      if (widget.currStep > 0) {
                        setState(() {
                          widget.currStep--;
                        });
                      }
                      widget.changeStep(widget.currStep);
                    },
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
                widget.currStep == widget.maxStep
                    ? RaisedButton(
                        color: Theme.of(context).buttonColor,
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {
                          final isValid =
                              widget.formKey.currentState.validate();
                          if (isValid) {
                            setState(() {
                              widget.currStep++;
                            });
                            widget.changeStep(widget.currStep);
                          }
                        },
                      )
                    : FlatButton(
                        onPressed: () {
                          final isValid =
                              widget.formKey.currentState.validate();
                          if (isValid) {
                            setState(() {
                              widget.currStep++;
                            });
                            widget.changeStep(widget.currStep);
                          }
                        },
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
