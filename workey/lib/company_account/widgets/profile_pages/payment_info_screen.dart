import 'package:flutter/material.dart';

import '../../widgets/payment_screen_widgets/credit_card.dart';
import '../../widgets/payment_screen_widgets/credit_card_type.dart';
import '../../widgets/payment_screen_widgets/credit_card_background.dart';

class PaymentInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CreditCard(
        cardNumber: "5450 7879 4864 7854",
        cardExpiry: "10/25",
        cardHolderName: "Card Holder",
        cvv: "456",
        bankName: "Axis Bank",
        cardType:
            CardType.masterCard, // Optional if you want to override Card Type
        showBackSide: false,
        frontBackground: CreditCardBackground.black,
        backBackground: CreditCardBackground.white,
        showShadow: true,
      ),
    );
  }
}
