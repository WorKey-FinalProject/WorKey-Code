import 'package:flutter/material.dart';

import '../screens/add_employee_confirm_screen.dart';
import '../../general/models/personal_account_model.dart';
import '../../general/providers/company_groups.dart';

class AddEmployeeForm extends StatefulWidget {
  final CompanyGroups provider;

  AddEmployeeForm(this.provider);
  @override
  _AddEmployeeForm createState() => _AddEmployeeForm();
}

class _AddEmployeeForm extends State<AddEmployeeForm> {
  // final workGroupLocationController = GoogleMapController;
  List<PersonalAccountModel> personalAccountList = [];
  List<PersonalAccountModel> tempSearchList = [];

  _searchNewEmployee(String searchValue) {
    if (searchValue.isEmpty) {
      setState(() {
        personalAccountList = [];
        tempSearchList = [];
      });
    } else {
      personalAccountList.forEach((element) {
        if (element.email.startsWith(searchValue)) {
          setState(() {
            tempSearchList.add(element);
          });
        }
      });
    }
  }

  Future<List<PersonalAccountModel>> _fetchPersonalList() async {
    personalAccountList = await widget.provider.getAllPersonalAccounts()
        as List<PersonalAccountModel>;
    return personalAccountList;
  }

  @override
  Widget build(BuildContext context) {
    _fetchPersonalList();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (searchValue) => _searchNewEmployee(searchValue),
                decoration: InputDecoration(
                  //prefixIcon: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black),iconSize: 20.0,onPressed: ,),
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Search Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  print(tempSearchList[index].id);

                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEmployeeConfirmScreen(
                            widget.provider, tempSearchList[index].id),
                      ),
                    ),
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              tempSearchList[index].profilePicture),
                        ),
                        title: Text(
                          '${tempSearchList[index].firstName}',
                          style: Theme.of(context).textTheme.title,
                        ),
                        subtitle: Text(
                          '${tempSearchList[index].lastName}',
                        ),
                        trailing: MediaQuery.of(context).size.width > 460
                            ? FlatButton.icon(
                                icon: Icon(Icons.person_outline_rounded),
                                label: Text('Employee details'),
                                onPressed:
                                    null, //() => deleteTx(emp[index].id),
                                textColor: Theme.of(context).accentColor,
                              )
                            : IconButton(
                                icon: Icon(Icons.person_outline_rounded),
                                color: Theme.of(context).accentColor,
                                onPressed: () =>
                                    null //deleteTx(transactions[index].id),
                                ),
                      ),
                    ),
                  );
                },
                itemCount: tempSearchList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
