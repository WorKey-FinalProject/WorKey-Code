import 'package:flutter/material.dart';
import 'package:workey/company_account/widgets/employee_sliver.dart';

import '../widgets/group_screen_widgets/opaque_image.dart';
import '../widgets/employees_shifts_view.dart';
import '../widgets/employees_info_view.dart';

class EmployeeDetailScreen extends StatefulWidget {
  @override
  _EmployeeDetailScreenState createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  final List _tabs = [
    EmployeesInfoView(),
    EmployeesShiftsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    pinned: true,
                    floating: false,
                    expandedHeight: 200,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      background: OpaqueImage(
                        imageUrl:
                            'https://pbs.twimg.com/profile_images/1192101281252495363/c_xL2w3j.jpg',
                      ),
                    ),
                    forceElevated: innerBoxIsScrolled,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(50),
                      child: Container(
                        width: double.maxFinite,
                        color: Colors.white.withOpacity(0.8),
                        child: TabBar(
                          tabs: _tabs
                              .map(
                                (tab) => Tab(
                                  child: Text(
                                    tab.getName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: _tabs.map((tab) {
                return SafeArea(
                  top: false,
                  bottom: false,
                  child: Builder(
                    builder: (BuildContext context) {
                      return CustomScrollView(
                        key: PageStorageKey<String>(tab.getName),
                        slivers: <Widget>[
                          SliverOverlapInjector(
                            handle:
                                NestedScrollView.sliverOverlapAbsorberHandleFor(
                                    context),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.all(8.0),
                            sliver: SliverFixedExtentList(
                              itemExtent: 48.0,
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return tab;
                                },
                                childCount: 1,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        // body: NestedScrollView(
        //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        //     return <Widget>[
        //       SliverOverlapAbsorber(
        //         handle:
        //             NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        //         sliver: SliverAppBar(
        //           pinned: true,
        //           floating: false,
        //           expandedHeight: 200,
        //           flexibleSpace: FlexibleSpaceBar(
        //             centerTitle: true,
        //             background: OpaqueImage(
        //               imageUrl:
        //                   'https://pbs.twimg.com/profile_images/1192101281252495363/c_xL2w3j.jpg',
        //             ),
        //           ),
        //           forceElevated: innerBoxIsScrolled,
        //           bottom: PreferredSize(
        //             preferredSize: Size.fromHeight(50),
        //             child: Container(
        //               width: double.maxFinite,
        //               color: Colors.white.withOpacity(0.8),
        //               child: TabBar(

        //                 tabs: _tabs
        //                     .map(
        //                       (tab) => Tab(
        //                         child: Text(
        //                           tab.getName,
        //                           style: TextStyle(
        //                             fontWeight: FontWeight.bold,
        //                             color: Colors.black,
        //                           ),
        //                         ),
        //                       ),
        //                     )
        //                     .toList(),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ];
        //   },
        //   body: TabBarView(
        //     children: _tabs.map((tab) {
        //       return SafeArea(
        //         top: false,
        //         bottom: false,
        //         child: Builder(
        //           builder: (BuildContext context) {
        //             return CustomScrollView(
        //               key: PageStorageKey<String>(tab.getName),
        //               slivers: <Widget>[
        //                 SliverOverlapInjector(
        //                   handle:
        //                       NestedScrollView.sliverOverlapAbsorberHandleFor(
        //                           context),
        //                 ),
        //                 SliverPadding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   sliver: SliverFixedExtentList(
        //                     itemExtent: 48.0,
        //                     delegate: SliverChildBuilderDelegate(
        //                       (BuildContext context, int index) {
        //                         return tab;
        //                       },
        //                       childCount: 1,
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             );
        //           },
        //         ),
        //       );
        //     }).toList(),
        //   ),
      ),
    );
  }
}
