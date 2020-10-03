import 'package:flutter/material.dart';
import 'package:workey/personal_account/widgets/group_top_view.dart';
import 'package:workey/personal_account/widgets/icons_grid_view.dart';

class GroupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: constraints.maxHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: GroupTopView(
                    constraints.maxHeight * 0.35,
                    constraints.maxWidth,
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: IconsGridView(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
