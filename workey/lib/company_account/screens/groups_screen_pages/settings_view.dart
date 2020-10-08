import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/models/work_group_model.dart';
import 'package:workey/general/providers/auth.dart';
import 'package:workey/general/providers/company_groups.dart';
import 'package:workey/general/widgets/profile_picture.dart';
import 'package:workey/personal_account/widgets/icons_grid_view.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  TextEditingController groupNewNameController;

  String _getCompanysEmployeeCount(workGroupsProvider) {
    int count = 0;
    List<WorkGroupModel> list = workGroupsProvider.getWorkGroupsList;
    list.forEach((element) {
      count += element.employeeList.length;
    });
    return count.toString();
  }

  @override
  void dispose() {
    groupNewNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final companyAccount = Provider.of<Auth>(context).companyAccountModel;
    final workGroupsProvider = Provider.of<CompanyGroups>(context);

    var employeesCount = _getCompanysEmployeeCount(workGroupsProvider);

    Widget textView(
      String title,
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
                  ? workGroupsProvider.getCurrentWorkGroup == null
                      ? Text(employeesCount)
                      : workGroupsProvider.getCurrentWorkGroup.employeeList ==
                              null
                          ? Text('0')
                          : Text(
                              '${workGroupsProvider.getCurrentWorkGroup.employeeList.length}')
                  : Text('no data')
            ],
          ),
        ),
      );
    }

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: new Container(
                margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black,
                  height: 36,
                ),
              ),
            ),
            Text("Group\'s Info"),
            Expanded(
              child: new Container(
                margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                child: Divider(
                  color: Colors.black,
                  height: 36,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ProfilePicture(
              size: 80,
              isEditable: true,
              imageUrl: workGroupsProvider.getCurrentWorkGroup == null
                  ? companyAccount.imageFile.toString()
                  : workGroupsProvider.getCurrentWorkGroup.imageFile.toString(),
            ),
            textEditaleView(
                workGroupsProvider.getCurrentWorkGroup == null
                    ? companyAccount.companyName
                    : workGroupsProvider.getCurrentWorkGroup.workGroupName,
                groupNewNameController),
          ],
        ),
        textView('Number Of Employees'),
        workGroupsProvider.getCurrentWorkGroup == null
            ? Container()
            : Row(
                children: <Widget>[
                  Expanded(
                    child: new Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      ),
                    ),
                  ),
                  Text("Icons"),
                  Expanded(
                    child: new Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      ),
                    ),
                  ),
                ],
              ),
        workGroupsProvider.getCurrentWorkGroup == null
            ? Container()
            : Expanded(
                child: IconsGridView(),
              ),
      ],
    );
  }

  Widget textEditaleView(
    String title,
    TextEditingController controller,
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
          controller: controller,
          onSaved: (value) {
            setState(() {
              controller.text = value;
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
