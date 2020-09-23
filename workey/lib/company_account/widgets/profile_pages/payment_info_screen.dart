import 'package:flutter/material.dart';

import '../../widgets/payment_screen_widgets/credit_card.dart';
import '../../widgets/payment_screen_widgets/credit_card_type.dart';
import '../../widgets/payment_screen_widgets/credit_card_background.dart';

class PaymentInfoScreen extends StatefulWidget {
  @override
  _PaymentInfoScreenState createState() => _PaymentInfoScreenState();
}

class _PaymentInfoScreenState extends State<PaymentInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final cardNumberController = TextEditingController();

  //String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvv = '';
  bool showBack = false;

  FocusNode _focusNode;

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
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          CreditCard(
            cardNumber: cardNumberController.text,
            cardExpiry: expiryDate,
            cardHolderName: cardHolderName,
            cardType: CardType.visa,
            cvv: cvv,
            bankName: 'Axis Bank',
            showBackSide: showBack,
            frontBackground: CreditCardBackground.black,
            backBackground: CreditCardBackground.white,
            showShadow: true,
          ),
          SizedBox(
            height: 40,
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    controller: cardNumberController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter card number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: 'Card Number'),
                    maxLength: 19,
                    onChanged: (value) {
                      setState(() {
                        cardNumberController.text = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Card Expiry'),
                    maxLength: 5,
                    onChanged: (value) {
                      setState(() {
                        expiryDate = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Card Holder Name'),
                    onChanged: (value) {
                      setState(() {
                        cardHolderName = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'CVV'),
                    maxLength: 3,
                    onChanged: (value) {
                      setState(() {
                        cvv = value;
                      });
                    },
                    focusNode: _focusNode,
                  ),
                ),
              ],
            ),
          ),
          RaisedButton(
            onPressed: () {
              _trySubmit();
            },
            child: Text('save'),
          ),
        ],
      ),
    );
  }
}
