import 'package:flutter/material.dart';
import 'package:workey/company_account/widgets/profile_picture.dart';
import 'package:workey/general/models/work_group_model.dart';

class SubGroupsList extends StatefulWidget {
  final isShrink;

  SubGroupsList(this.isShrink);

  @override
  _SubGroupsListState createState() => _SubGroupsListState();
}

class _SubGroupsListState extends State<SubGroupsList> {
  double heightForMargin = 0;
  List<WorkGroupModel> subGroupsList = [];

  @override
  Widget build(BuildContext context) {
    var addEmployeeButton = Container(
      padding: EdgeInsets.only(
        bottom: 10,
        top: 20,
      ),
      alignment:
          subGroupsList.isEmpty ? Alignment.center : Alignment.bottomRight,
      child: RawMaterialButton(
        onPressed: () {},
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
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.grey,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'LOGO',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
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
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.grey,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: ProfilePicture(
                                              imageUrl: subGroupsList[index]
                                                  .workGroupLogo,
                                              size: 150,
                                              isEditable: false,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Text(
                                          subGroupsList[index].toString(),
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
}
