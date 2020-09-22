import 'package:flutter/material.dart';

import '../../widgets/payment_screen_widgets/credit_card.dart';
import '../../widgets/payment_screen_widgets/credit_card_type.dart';
import '../../widgets/payment_screen_widgets/credit_card_background.dart';

class PaymentInfoScreen extends StatefulWidget {
  @override
  _PaymentInfoScreenState createState() => _PaymentInfoScreenState();
}

class _PaymentInfoScreenState extends State<PaymentInfoScreen> {
  String cardNumber = "";
  String cardHolderName = "";
  String expiryDate = "";
  String cvv = "";
  bool showBack = false;

  FocusNode _focusNode;

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
            cardNumber: cardNumber,
            cardExpiry: expiryDate,
            cardHolderName: cardHolderName,
            cardType: CardType.visa,
            cvv: cvv,
            bankName: "Axis Bank",
            showBackSide: showBack,
            frontBackground: CreditCardBackground.black,
            backBackground: CreditCardBackground.white,
            showShadow: true,
          ),
          SizedBox(
            height: 40,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: TextFormField(
                  decoration: InputDecoration(hintText: "Card Number"),
                  maxLength: 19,
                  onChanged: (value) {
                    setState(() {
                      cardNumber = value;
                    });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: TextFormField(
                  decoration: InputDecoration(hintText: "Card Expiry"),
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
                  decoration: InputDecoration(hintText: "Card Holder Name"),
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
                  decoration: InputDecoration(hintText: "CVV"),
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
          )
        ],
      ),
    );
  }
}
