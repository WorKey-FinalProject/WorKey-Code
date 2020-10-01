import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workey/company_account/screens/add_workgroup_screen.dart';
import 'package:workey/general/widgets/profile_picture.dart';
import 'package:workey/general/models/snackbar_result.dart';
import 'package:workey/general/models/work_group_model.dart';
import 'package:workey/general/providers/company_groups.dart';

class SubGroupsList extends StatefulWidget {
  final isShrink;

  SubGroupsList(
    this.isShrink,
  );

  @override
  _SubGroupsListState createState() => _SubGroupsListState();
}

class _SubGroupsListState extends State<SubGroupsList> {
  double heightForMargin = 0;
  List<WorkGroupModel> subGroupsList = [];

  @override
  Widget build(BuildContext context) {
    final subWorkGroupsProvider = Provider.of<CompanyGroups>(context);
    subGroupsList = subWorkGroupsProvider.getWorkGroupsList;

    var addEmployeeButton = Container(
      padding: EdgeInsets.only(
        bottom: 10,
        top: 20,
      ),
      alignment:
          subGroupsList.isEmpty ? Alignment.center : Alignment.bottomRight,
      child: RawMaterialButton(
        onPressed: () => _showSnackBarResult(context),
        elevation: 2.0,
        fillColor: Theme.of(context).accentColor,
        child: Icon(
          Icons.add,
          size: 35.0,
        ),
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(),
      ),
    );

    return subGroupsList.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  'There are no work-groups yet',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'To add new  work-group click on the plus button',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              addEmployeeButton,
            ],
          )
        : LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: <Widget>[
                  ListView.builder(
                    scrollDirection:
                        widget.isShrink ? Axis.vertical : Axis.horizontal,
                    itemCount: subGroupsList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 200,
                        height: 200,
                        child: Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 25, horizontal: 20),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          child: Container(
                            child: widget.isShrink
                                ? Row(
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        fit: FlexFit.tight,
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(10),
                                          child: ProfilePicture(
                                            imageUrl: subGroupsList[index]
                                                .workGroupLogo,
                                            size: 150,
                                            isEditable: false,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Text(
                                          subGroupsList[index].workGroupName,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        fit: FlexFit.tight,
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(10),
                                          child: ProfilePicture(
                                            imageUrl: subGroupsList[index]
                                                .workGroupLogo,
                                            size: 150,
                                            isEditable: false,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Text(
                                          subGroupsList[index].workGroupName,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                  addEmployeeButton,
                ],
              );
            },
          );
  }

  _showSnackBarResult(BuildContext context) async {
    final SnackBarResult snackBarResult = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddWorkGroupScreen(),
      ),
    );

    if (snackBarResult?.message != null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            snackBarResult.message,
            textAlign: TextAlign.center,
          ),
          backgroundColor: snackBarResult.isError
              ? Theme.of(context).errorColor
              : Colors.blue,
        ),
      );
    }
  }
}
