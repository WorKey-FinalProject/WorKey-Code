import 'package:flutter/material.dart';
import 'package:workey/general/models/group_employee_model.dart';

import 'package:workey/general/models/mail.dart';

class MailItem extends StatelessWidget {
  final Mail mail;
  final GroupEmployeeModel groupMember;

  MailItem(this.mail, this.groupMember);

  @override
  Widget build(BuildContext context) {
    // PersonalAccountModel user =

    return Container(
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
                child: Image.network(
                  groupMember.picture,
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
                          style: TextStyle(color: Colors.grey, fontSize: 12.0),
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
                          style: TextStyle(color: Colors.black, fontSize: 12.0),
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
    );
  }
}
