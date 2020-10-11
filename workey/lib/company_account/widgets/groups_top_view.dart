import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/models/company_account_model.dart';
import 'package:workey/general/models/work_group_model.dart';
import 'package:workey/general/providers/company_groups.dart';
import 'package:workey/general/widgets/profile_picture.dart';

class GroupsTopView extends StatefulWidget {
  final double constraintsMaxHeight;
  final double constraintsMaxWidth;
  final CompanyAccountModel companyAccount;
  final WorkGroupModel currentWorkGroup;

  GroupsTopView(
    this.constraintsMaxHeight,
    this.constraintsMaxWidth,
    this.companyAccount,
    this.currentWorkGroup,
  );

  @override
  _GroupsTopViewState createState() => _GroupsTopViewState();
}

class _GroupsTopViewState extends State<GroupsTopView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.constraintsMaxHeight,
      color: Theme.of(context).accentColor,
      child: Stack(
        children: <Widget>[
          Container(
            height: widget.constraintsMaxHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(70),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ),
          Positioned(
            bottom: 70,
            right: 0,
            left: 0,
            top: 0,
            child: Container(
              child: ProfilePicture(
                size: MediaQuery.of(context).size.height * 0.2,
                isEditable: false,
                imageUrl: widget.currentWorkGroup == null
                    ? widget.companyAccount.companyLogo
                    : widget.currentWorkGroup.logo,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 0,
            child: Container(
              width: widget.constraintsMaxWidth * 0.9,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
                // boxShadow: [
                //   BoxShadow(
                //     offset: Offset(0, 5),
                //     blurRadius: 50,
                //     color: Color(0xFF12153D).withOpacity(0.2),
                //   )
                // ],
              ),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 10),
                child: FittedBox(
                  child: Text(
                    widget.currentWorkGroup == null
                        ? widget.companyAccount.companyName
                        : widget.currentWorkGroup.workGroupName,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
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
