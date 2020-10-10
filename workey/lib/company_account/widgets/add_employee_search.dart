import 'package:flutter/material.dart';

import 'add_employee_confirm.dart';
import '../../general/models/personal_account_model.dart';
import '../../general/providers/company_groups.dart';

class AddEmployeeSearch extends StatefulWidget {
  final CompanyGroups provider;
  final Function selectEmp;

  AddEmployeeSearch(this.provider, this.selectEmp);
  @override
  _AddEmployeeForm createState() => _AddEmployeeForm();
}

class _AddEmployeeForm extends State<AddEmployeeSearch> {
  List<PersonalAccountModel> personalAccountList = [];
  List<PersonalAccountModel> tempSearchList = [];

  _searchNewEmployee(String searchValue) {
    if (searchValue.isEmpty) {
      setState(() {
        personalAccountList = [];
        tempSearchList = [];
      });
    } else {
      List<PersonalAccountModel> fittedValues = [];
      personalAccountList.forEach(
        (element) {
          if (element.email.startsWith(searchValue)) {
            fittedValues.add(element);
          }
        },
      );
      setState(() {
        tempSearchList = fittedValues;
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
                keyboardType: TextInputType.emailAddress,
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
                    onTap: () => widget.selectEmp(tempSearchList[index]),
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            tempSearchList[index].profilePicture,
                          ),
                        ),
                        title: Text(
                          '${tempSearchList[index].email}',
                          style: Theme.of(context).textTheme.title,
                        ),
                        subtitle: Text(
                          '${tempSearchList[index].firstName} ${tempSearchList[index].lastName}',
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
