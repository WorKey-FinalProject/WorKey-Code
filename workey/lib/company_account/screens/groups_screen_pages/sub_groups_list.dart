import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
  CompanyGroups subWorkGroupsProvider;
  double heightForMargin = 0;
  List<WorkGroupModel> subGroupsList = [];
  WorkGroupModel currentWorkGroup;

  var isShrinkLocal = false;

  void updateCurrentWorkGroup(int index) async {
    if (currentWorkGroup != null) {
      if (currentWorkGroup.id == subGroupsList[index].id) {
        await subWorkGroupsProvider.setCurrentWorkGroup(null);
      } else {
        await subWorkGroupsProvider.setCurrentWorkGroup(subGroupsList[index]);
      }
    } else {
      await subWorkGroupsProvider.setCurrentWorkGroup(subGroupsList[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    subWorkGroupsProvider = Provider.of<CompanyGroups>(context);
    subGroupsList = subWorkGroupsProvider.getWorkGroupsList;
    currentWorkGroup = subWorkGroupsProvider.getCurrentWorkGroup;

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
        fillColor: Theme.of(context).buttonColor,
        child: Icon(
          Icons.add,
          size: 35.0,
        ),
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(),
      ),
    );
    if (widget.isShrink == true) {
      setState(() {
        isShrinkLocal = true;
      });
    } else {
      setState(() {
        isShrinkLocal = false;
      });
    }
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
                  AnimationLimiter(
                    child: ListView.builder(
                      scrollDirection:
                          widget.isShrink ? Axis.vertical : Axis.horizontal,
                      itemCount: subGroupsList.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Container(
                                width: 200,
                                height: 200,
                                child: Card(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 25, horizontal: 20),
                                  color: currentWorkGroup != null
                                      ? currentWorkGroup.id ==
                                              subGroupsList[index].id
                                          ? Colors.blue
                                          : Colors.white
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 5,
                                  child: AnimatedSwitcher(
                                    switchInCurve: Curves.easeInSine,
                                    switchOutCurve: Curves.easeInSine,
                                    duration: Duration(milliseconds: 200),
                                    child: isShrinkLocal
                                        ? groupsRowView(index)
                                        : groupsColumnView(index),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  addEmployeeButton,
                ],
              );
            },
          );
  }

  Widget groupsColumnView(int index) {
    return InkWell(
      onTap: () {
        updateCurrentWorkGroup(index);
      },
      borderRadius: BorderRadius.circular(15),
      child: Column(
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: ProfilePicture(
                imageUrl: subGroupsList[index].logo,
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
    );
  }

  Widget groupsRowView(int index) {
    return InkWell(
      onTap: () {
        updateCurrentWorkGroup(index);
      },
      borderRadius: BorderRadius.circular(15),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: ProfilePicture(
                imageUrl: subGroupsList[index].logo,
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
