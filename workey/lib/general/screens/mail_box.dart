import 'package:flutter/material.dart';

class MailBox extends StatefulWidget {
  @override
  _MailBoxState createState() => _MailBoxState();
}

class _MailBoxState extends State<MailBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue[50].withOpacity(0.5),
      backgroundColor: Colors.white.withOpacity(0.9),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300.0,
              decoration: BoxDecoration(
                  color: Colors.blue[600],
                  // color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0),
                  )),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 70.0),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "All Mails",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "You have got 3 new mails",
                              style: TextStyle(
                                  color: Colors.blue[50], fontSize: 14.0),
                            )
                          ],
                        ),
                        Spacer(),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.add),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 70.0,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Container(
                        height: 70.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            // color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                      Positioned(
                        bottom: 10.0,
                        child: Container(
                          height: 70.0,
                          width: 330.0,
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                      ),
                      Positioned(
                        bottom: 20.0,
                        child: buildMailItem(),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "RECENTS",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "(634 mails)",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            buildMailItem(),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 100.0,
            ),
          ],
        ),
      ),
    );
  }

  InkWell buildMailItem() {
    return InkWell(
      onTap: () {
        openBottomSheet();
      },
      child: Container(
        height: 95.0,
        width: 350.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Image.asset(
                    'assets/images/google-icon.png',
                    height: 60.0,
                    width: 60.0,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Protorix Code",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                          Spacer(),
                          Text(
                            "8:16 AM",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12.0),
                          ),
                        ],
                      ),
                      Text(
                        "Your opinion matters",
                        style: TextStyle(color: Colors.black, fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "You have a mail. Check it!",
                            style:
                                TextStyle(color: Colors.black, fontSize: 12.0),
                          ),
                          Spacer(),
                          Icon(
                            Icons.star_border,
                            color: Colors.orange,
                            size: 20.0,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void openBottomSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 500.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Image.asset(
                              'assets/images/google-icon.png',
                              height: 60.0,
                              width: 60.0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Protorix Code",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.delete_outline,
                                      color: Colors.blue[700],
                                    ),
                                    Icon(
                                      Icons.more_vert,
                                      color: Colors.blue[700],
                                    ),
                                  ],
                                ),
                                Text(
                                  "Your opinion matters",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.0),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Code,",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "To add custom fonts to your application, add a fonts section here,in this section. Each entry in this list should have a key with the font family name, and a ",
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "Thank you,",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Protorix Code",
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Reply..",
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 18.0),
                            ),
                            Spacer(),
                            CircleAvatar(
                              backgroundColor: Colors.blue[600],
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
