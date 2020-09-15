import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:workey/company_account/widgets/profile_screen_widgets/profile_picture.dart';
import 'package:workey/general/providers/global_sizes.dart';

class GroupsScreen2 extends StatefulWidget {
  @override
  _GroupsScreen2State createState() => _GroupsScreen2State();
}

class _GroupsScreen2State extends State<GroupsScreen2> {
  @override
  Widget build(BuildContext context) {
    var appBarHeight = Provider.of<GlobalSizes>(context).getAppBarHeight;

    //print();

    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (ctx, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: constraints.maxHeight * 0.4,
                  toolbarHeight: 100,
                  pinned: true,
                  floating: false,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Container(
                      margin: EdgeInsets.only(top: kToolbarHeight + 24),
                      child: Stack(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: ProfilePicture(
                              imageUrl:
                                  'https://pbs.twimg.com/profile_images/1192101281252495363/c_xL2w3j.jpg',
                              size: MediaQuery.of(context).size.height * 0.14,
                              isEditable: false,
                            ),
                          ),
                          Text('text'),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  height: 40,
                  child: Text(index.toString()),
                );
              },
              itemCount: 100,
            ),
          ),
        );
      },
    );
  }
}
