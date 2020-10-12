import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/models/group_employee_model.dart';
import 'package:workey/general/providers/auth.dart';
import 'package:workey/general/providers/company_groups.dart';
import 'package:workey/general/widgets/profile_picture.dart';
import 'package:workey/personal_account/widgets/icons_grid_view.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String groupNewName;

  Widget textView(
    String title,
    List<GroupEmployeeModel> employeesList,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        height: 50,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.0),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            title == 'Number Of Employees'
                ? Text('${employeesList.length}')
                : Text('no data')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final companyAccount = Provider.of<Auth>(context).companyAccountModel;
    final workGroupsProvider = Provider.of<CompanyGroups>(context);

    final employeesList = workGroupsProvider.getEmployeeList;

    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              margin: const EdgeInsets.only(left: 10.0, right: 20.0),
              child: Divider(
                color: Colors.black,
                height: 36,
              ),
            ),
            Text("Group\'s Info"),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              margin: const EdgeInsets.only(left: 20.0, right: 10.0),
              child: Divider(
                color: Colors.black,
                height: 36,
              ),
            ),
          ],
        ),
        if (workGroupsProvider.getCurrentWorkGroup != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ProfilePicture(
                size: 100,
                isEditable: true,
                imageUrl: workGroupsProvider.getCurrentWorkGroup.logo,
              ),
              textEditaleView(
                workGroupsProvider.getCurrentWorkGroup == null
                    ? companyAccount.companyName
                    : workGroupsProvider.getCurrentWorkGroup.workGroupName,
                groupNewName,
              ),
            ],
          ),
        textView('Number Of Employees', employeesList),
        if (workGroupsProvider.getCurrentWorkGroup != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black,
                  height: 36,
                ),
              ),
              Text("Icons"),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                child: Divider(
                  color: Colors.black,
                  height: 36,
                ),
              ),
            ],
          ),
        if (workGroupsProvider.getCurrentWorkGroup != null) IconsGridView(),
      ],
    );
  }

  Widget textEditaleView(
    String title,
    String groupNewName,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        height: 50,
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.0),
          color: Colors.grey.withOpacity(0.2),
        ),
        child: TextFormField(
          onSaved: (value) {
            setState(() {
              groupNewName = value;
            });
          },
          decoration: InputDecoration(
            labelText: title,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
