import 'package:flutter/material.dart';
import 'package:workey/general/models/group_employee_model.dart';

import 'package:workey/general/models/mail.dart';

class MailItem extends StatelessWidget {
  final Mail mail;
  final GroupEmployeeModel groupMember;
  final Function selectedMail;

  MailItem(this.mail, this.groupMember, this.selectedMail);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        child: FlatButton(
          height: 100,
          onPressed: () => selectedMail(mail, groupMember),
          child: Container(
            height: 95.0,
            width: double.infinity,
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
                      child: groupMember.picture.isEmpty
                          ? Container(
                              alignment: Alignment.center,
                              height: 60.0,
                              width: 60.0,
                              child: Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                            )
                          : Image.network(
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
                                '${groupMember.firstName} ${groupMember.lastName}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                              Spacer(),
                              Text(
                                mail.sendTime.toString(),
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12.0),
                              ),
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                            ),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  mail.title,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.0),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.star_border,
                                  color: Colors.orange,
                                  size: 20.0,
                                )
                              ],
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
        ),
      ),
    );
  }
}
