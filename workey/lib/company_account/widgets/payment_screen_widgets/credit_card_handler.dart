import 'package:flutter/material.dart';

import 'credit_card_type.dart';

Widget getCardTypeIcon({CardType cardType, String cardNumber}) {
  switch (cardType == null ? getCardType(cardNumber) : cardType) {
    case CardType.americanExpress:
      return Image.asset(
        'assets/images/american_express.png',
        width: 55,
        height: 40,
      );
    case CardType.dinersClub:
      return Image.asset(
        'assets/images/diners_club.png',
        width: 40,
        height: 40,
      );
    case CardType.discover:
      return Image.asset(
        'assets/images/discover.png',
        width: 70,
        height: 50,
      );
    case CardType.jcb:
      return Image.asset(
        'assets/images/jcb.png',
        width: 40,
        height: 40,
      );
    case CardType.masterCard:
      return Image.asset(
        'assets/images/master_card.png',
        width: 55,
        height: 40,
      );
    case CardType.maestro:
      return Image.asset(
        'assets/images/maestro.png',
        width: 55,
        height: 40,
      );
    case CardType.rupay:
      return Image.asset(
        'assets/images/rupay.png',
        width: 80,
        height: 50,
      );
    case CardType.visa:
      return Image.asset(
        'assets/images/visa.png',
        width: 55,
        height: 40,
      );
    default:
      return Container();
  }
}

CardType getCardType(String cardNumber) {
  RegExp rAmericanExpress = new RegExp(r"^3[47][0-9]{0,}$");
  RegExp rDinersClub = new RegExp(r"^3(?:0[0-59]{1}|[689])[0-9]{0,}$");
  RegExp rDiscover = new RegExp(
      r"^(6011|65|64[4-9]|62212[6-9]|6221[3-9]|622[2-8]|6229[01]|62292[0-5])[0-9]{0,}$");
  RegExp rJcb = new RegExp(r"^(?:2131|1800|35)[0-9]{0,}$");
  RegExp rMasterCard =
      new RegExp(r"^(5[1-5]|222[1-9]|22[3-9]|2[3-6]|27[01]|2720)[0-9]{0,}$");
  RegExp rMaestro = new RegExp(r"^(5[06789]|6)[0-9]{0,}$");
  RegExp rRupay = new RegExp(r"^(6522|6521|60)[0-9]{0,}$");
  RegExp rVisa = new RegExp(r"^4[0-9]{0,}$");

  // Remove all the spaces from the card number
  cardNumber = cardNumber.trim().replaceAll(" ", "");

  if (rAmericanExpress.hasMatch(cardNumber)) {
    return CardType.americanExpress;
  } else if (rMasterCard.hasMatch(cardNumber)) {
    return CardType.masterCard;
  } else if (rVisa.hasMatch(cardNumber)) {
    return CardType.visa;
  } else if (rDinersClub.hasMatch(cardNumber)) {
    return CardType.dinersClub;
  } else if (rRupay.hasMatch(cardNumber)) {
    // Additional check to see if it's a discover card
    // Some discover card starts with 6011 and some rupay card starts with 60
    // If the card number matches the 6011 then it must be discover.

    // Note: Keep rupay check before the discover check
    if (rDiscover.hasMatch(cardNumber)) {
      return CardType.discover;
    } else {
      return CardType.rupay;
    }
  } else if (rDiscover.hasMatch(cardNumber)) {
    return CardType.discover;
  } else if (rJcb.hasMatch(cardNumber)) {
    return CardType.jcb;
  } else if (rMaestro.hasMatch(cardNumber)) {
    return CardType.maestro;
  }

  return CardType.other;
}
