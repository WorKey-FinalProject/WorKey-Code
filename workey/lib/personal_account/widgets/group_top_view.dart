import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/models/work_group_model.dart';
import 'package:workey/general/providers/company_groups.dart';
import 'package:workey/general/widgets/profile_picture.dart';

class GroupTopView extends StatefulWidget {
  final double constraintsMaxHeight;
  final double constraintsMaxWidth;

  GroupTopView(this.constraintsMaxHeight, this.constraintsMaxWidth);

  @override
  _GroupTopViewState createState() => _GroupTopViewState();
}

class _GroupTopViewState extends State<GroupTopView> {
  WorkGroupModel workGroup;
  @override
  Widget build(BuildContext context) {
    final companyGroupsProvider = Provider.of<CompanyGroups>(context);
    workGroup = companyGroupsProvider.getCurrentWorkGroup;
    return Container(
      height: widget.constraintsMaxHeight,
      child: Stack(
        children: <Widget>[
          Container(
            height: widget.constraintsMaxHeight - 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ),
          Positioned(
            bottom: 110,
            right: 0,
            left: 0,
            top: 0,
            child: Container(
              child: ProfilePicture(
                size: MediaQuery.of(context).size.height * 0.2,
                isEditable: false,
                imageUrl: '',
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: widget.constraintsMaxWidth * 0.9,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 50,
                    color: Color(0xFF12153D).withOpacity(0.2),
                  )
                ],
              ),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '${workGroup.workGroupName}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
