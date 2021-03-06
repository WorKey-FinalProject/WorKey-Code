import 'package:flutter/material.dart';

class CreditCardFront {
  String bankName;
  TextEditingController cardNumber;
  TextEditingController cardExpiry;
  TextEditingController cardHolderName;
  Widget cardTypeIcon;
  double cardWidth;
  double cardHeight;
  Color textColor;

  CreditCardFront(
      {this.bankName = '',
      this.cardNumber,
      this.cardExpiry,
      this.cardHolderName,
      this.cardTypeIcon,
      this.cardWidth = 0,
      this.cardHeight = 0,
      this.textColor});

  Widget layout1() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 30,
                child: Center(
                  child: Text(
                    bankName,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/images/card_types/contactless_icon.png',
                    fit: BoxFit.fitHeight,
                    width: 30.0,
                    height: 30.0,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Flexible(
                            child: TextFormField(
                              controller: cardNumber,
                              decoration: InputDecoration(
                                hintText: 'XXXX XXXX XXXX XXXX',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'MavenPro',
                                  fontSize: 22),
                            ),
                          ),
                          // Text(
                          //   cardNumber == null || cardNumber.isEmpty
                          //       ? 'XXXX XXXX XXXX XXXX'
                          //       : cardNumber,
                          //   style: TextStyle(
                          //       package: 'awesome_card',
                          //       color: textColor,
                          //       fontWeight: FontWeight.w500,
                          //       fontFamily: 'MavenPro',
                          //       fontSize: 22),
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Exp. Date",
                                style: TextStyle(
                                    color: textColor,
                                    fontFamily: 'MavenPro',
                                    fontSize: 15),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Flexible(
                                child: TextFormField(
                                  controller: cardExpiry,
                                  decoration: InputDecoration(
                                      hintText: 'MM/YY',
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none),
                                  style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'MavenPro',
                                      fontSize: 16),
                                ),
                              ),
                              // Text(
                              //   cardExpiry == null || cardExpiry.isEmpty
                              //       ? 'MM/YY'
                              //       : cardExpiry,
                              //   style: TextStyle(
                              //       package: 'awesome_card',
                              //       color: textColor,
                              //       fontWeight: FontWeight.w500,
                              //       fontFamily: 'MavenPro',
                              //       fontSize: 16),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Text(
                          //   cardHolderName == null || cardHolderName.isEmpty
                          //       ? 'Card Holder'
                          //       : cardHolderName,
                          //   style: TextStyle(
                          //       color: textColor,
                          //       fontWeight: FontWeight.w500,
                          //       fontFamily: 'MavenPro',
                          //       fontSize: 17),
                          // ),
                          Flexible(
                            child: TextFormField(
                              controller: cardHolderName,
                              decoration: InputDecoration(
                                  hintText: 'CARD HOLDER',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  disabledBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none),
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'MavenPro',
                                  fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                    ),
                    cardTypeIcon
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
