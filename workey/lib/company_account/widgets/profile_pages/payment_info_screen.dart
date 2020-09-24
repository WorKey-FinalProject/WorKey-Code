import 'package:flutter/material.dart';
import 'package:workey/company_account/widgets/payment_screen_widgets/credit_card_handler.dart';

import '../../widgets/payment_screen_widgets/credit_card.dart';
import '../../widgets/payment_screen_widgets/credit_card_type.dart';
import '../../widgets/payment_screen_widgets/credit_card_background.dart';

enum TextFieldType {
  cardNumber,
  expiryDate,
  cardHolderName,
  cvv,
}

class PaymentInfoScreen extends StatefulWidget {
  @override
  _PaymentInfoScreenState createState() => _PaymentInfoScreenState();
}

class _PaymentInfoScreenState extends State<PaymentInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cardHolderNameController = TextEditingController();
  final cvvController = TextEditingController();

  var _isLodding = false;

  bool showBack = false;

  var showCvv = true;
  final _formKeyForCvv = GlobalKey<FormState>();

  FocusNode _focusNode;

  //  Future<void> _trySubmit() async {
  //   final isValid = _formKey.currentState.validate();
  //   FocusScope.of(context).unfocus();

  //   if (isValid) {
  //     _formKey.currentState.save();
  //     // TODO: tomer add credit card details to Firebase.
  //     // database cardNumber = cardNumberController.text.trim();
  //     // database expiryDate = expiryDateController.text.trim();
  //     // database cardHolderName = cardHolderNameController.text.trim();
  //     // database cvv = cvvController.text.trim();
  //     try {
  //       await widget.auth.updateCurrUserData(userAccount);
  //     } on PlatformException catch (err) {
  //       var message = 'An error occurred';

  //       if (err.message != null) {
  //         message = err.message;
  //       }

  //       Scaffold.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(message),
  //           backgroundColor: Theme.of(context).errorColor,
  //         ),
  //       );
  //     } catch (err) {
  //       print(err);
  //     }
  //     Navigator.pop(context);
  //     Scaffold.of(context).showSnackBar(
  //       SnackBar(
  //         duration: Duration(seconds: 2),
  //         content: Text(
  //           'Changes saved successfully',
  //           textAlign: TextAlign.center,
  //         ),
  //         backgroundColor: Colors.blue,
  //       ),
  //     );
  //   }
  // }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();

    if (isValid) {
      _formKey.currentState.save();
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
  }

  @override
  void dispose() {
    cardNumberController.dispose();

    expiryDateController.dispose();
    cardHolderNameController.dispose();
    cvvController.dispose();

    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLodding
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                CreditCard(
                  cardNumber: cardNumberController.text,
                  cardExpiry: expiryDateController.text,
                  cardHolderName: cardHolderNameController.text,
                  cardType: getCardType(cardNumberController.text),
                  cvv: cvvController.text,
                  bankName: 'Axis Bank',
                  showBackSide: showBack,
                  frontBackground: CreditCardBackground.black,
                  backBackground: CreditCardBackground.white,
                  showShadow: true,
                ),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildTextField(
                          'Card Number',
                          TextFieldType.cardNumber,
                          cardNumberController,
                        ),
                        buildTextField(
                          'Card Expiry Date',
                          TextFieldType.expiryDate,
                          expiryDateController,
                        ),
                        buildTextField(
                          'Card Holder Name',
                          TextFieldType.cardHolderName,
                          cardHolderNameController,
                        ),
                        Container(
                          child: Form(
                            key: _formKeyForCvv,
                            child: buildTextField(
                                'CVV', TextFieldType.cvv, cvvController),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(10),
                  child: RaisedButton(
                    onPressed: () {
                      loadingOnScreenIndicator(context);
                      _trySubmit();
                    },
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget buildTextField(
    String labelText,
    TextFieldType textFieldType,
    TextEditingController textEditingController,
  ) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        controller: textEditingController,
        onChanged: textFieldType == TextFieldType.cardNumber
            ? (value) {
                setState(() {
                  cardNumberController.text = value;
                });
              }
            : textFieldType == TextFieldType.expiryDate
                ? (value) {
                    setState(() {
                      expiryDateController.text = value;
                    });
                  }
                : textFieldType == TextFieldType.cardHolderName
                    ? (value) {
                        setState(() {
                          cardHolderNameController.text = value;
                        });
                      }
                    : textFieldType == TextFieldType.cvv
                        ? (value) {
                            setState(() {
                              cvvController.text = value;
                            });
                          }
                        : null,
        keyboardType: textFieldType == TextFieldType.cardHolderName
            ? TextInputType.text
            : textFieldType == TextFieldType.expiryDate
                ? TextInputType.text
                : TextInputType.number,
        focusNode: textFieldType == TextFieldType.cvv ? _focusNode : null,
        maxLength: textFieldType == TextFieldType.cvv
            ? 3
            : textFieldType == TextFieldType.expiryDate ? 5 : null,
        onSaved: textFieldType == TextFieldType.cardNumber
            ? (value) {
                cardNumberController.text = value;
              }
            : textFieldType == TextFieldType.expiryDate
                ? (value) {
                    expiryDateController.text = value;
                  }
                : textFieldType == TextFieldType.cardHolderName
                    ? (value) {
                        cardHolderNameController.text = value;
                      }
                    : null,
        validator: textFieldType == TextFieldType.cardNumber
            ? (value) {
                if (value.isEmpty) {
                  return 'Please enter the card number.';
                }
                return null;
              }
            : textFieldType == TextFieldType.cvv
                ? (value) {
                    if (value.isEmpty || !(value.length == 3)) {
                      return 'Please enter 3 characters CVV';
                    }
                    return null;
                  }
                : textFieldType == TextFieldType.expiryDate
                    ? (value) {
                        if (value.isEmpty ||
                            !(value.substring(2, 3) == '/') ||
                            !(value.length == 5) ||
                            !(int.parse(value.substring(0, 2)) > 0) ||
                            !(int.parse(value.substring(0, 2)) < 31) ||
                            !(int.parse(value.substring(3)) > 0) ||
                            !(int.parse(value.substring(3)) < 12)) {
                          return 'Please enter a valid date.';
                        }
                        return null;
                      }
                    : null,
        obscureText: (textFieldType == TextFieldType.cvv) ? showCvv : false,
        decoration: InputDecoration(
          suffixIcon: (textFieldType == TextFieldType.cvv)
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showCvv = !showCvv;
                    });
                  },
                  icon: Icon(Icons.remove_red_eye),
                  color: Colors.grey,
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  loadingOnScreenIndicator(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
