import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/models/group_employee_model.dart';
import 'package:workey/general/models/mail.dart';
import 'package:workey/general/providers/auth.dart';
import 'package:workey/general/providers/company_groups.dart';
import 'package:workey/general/widgets/auth/signup_type.dart';
import 'package:workey/general/widgets/mail_item.dart';
import 'package:workey/personal_account/widgets/employee_list_item.dart';

class MailBox extends StatefulWidget {
  @override
  _MailBoxState createState() => _MailBoxState();
}

class _MailBoxState extends State<MailBox> {
  String userId = FirebaseAuth.instance.currentUser.uid;
  final titleTextController = TextEditingController();
  final contentTextController = TextEditingController();

  GroupEmployeeModel _selectedEmployee;
  List<GroupEmployeeModel> _dropdownItems = [];
  List<DropdownMenuItem<GroupEmployeeModel>> _dropdownMenuItems = [];

  List<DropdownMenuItem<GroupEmployeeModel>> buildDropDownMenuItems(
    List listItems,
  ) {
    List<DropdownMenuItem<GroupEmployeeModel>> items = List();
    for (GroupEmployeeModel listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: EmployeeListItem(
            groupEmployeeModel: listItem,
            isDropDownItem: true,
            imageRadius: 30,
          ),
          value: listItem,
        ),
      );
    }
    return items;
  }

  void fillDropDownList() {
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedEmployee =
        _dropdownItems.isEmpty ? null : _dropdownMenuItems[0].value;
  }

  @override
  Widget build(BuildContext context) {
    final _companyGroupsProvider =
        Provider.of<CompanyGroups>(context, listen: false);

    final _auth = Provider.of<Auth>(context);
    var userDetails = _auth.getDynamicUser;

    if (_auth.getAccountTypeChosen == AccountTypeChosen.company) {
      _dropdownItems = _companyGroupsProvider.getEmployeeList;
    } else {
      _dropdownItems = _companyGroupsProvider.getEmployeeList
          .where((emp) => emp.id != userDetails.id)
          .toList();
    }

    return Scaffold(
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
                        InkWell(
                          onTap: () {
                            openNewMailBottomSheet();
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.add),
                          ),
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
                        child: InkWell(
                          onTap: () {
                            openBottomSheet();
                          },
                          child: MailItem(),
                        ),
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
            Container(
              height: 500,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users/$userId/mails')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return MailItem();
                    },
                  );
                },
              ),
            ),
            InkWell(
              onTap: () {
                openBottomSheet();
              },
              child: MailItem(),
            ),
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
                      borderRadius: BorderRadius.circular(30.0),
                    ),
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
      },
    );
  }

  void openNewMailBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (context, setModalState) => Padding(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: DropdownButton<GroupEmployeeModel>(
                          isExpanded: true,
                          value: _selectedEmployee,
                          items: _dropdownMenuItems,
                          itemHeight: 80,
                          onChanged: (value) {
                            setModalState(() {
                              _selectedEmployee = value;
                            });
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          Positioned(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: titleTextController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: 'Title',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          Positioned(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: contentTextController,
                                maxLines: 10,
                                decoration: InputDecoration(
                                  hintText: 'Description',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Send',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              fillDropDownList();

                              Mail mail = Mail(
                                sentFrom: userId,
                                sentTo: _selectedEmployee.id,
                                title: titleTextController.text,
                                content: contentTextController.text,
                              );
                              await FirebaseFirestore.instance
                                  .collection('users/$userId/mails')
                                  .add(mail.toJson());
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.blue[600],
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
