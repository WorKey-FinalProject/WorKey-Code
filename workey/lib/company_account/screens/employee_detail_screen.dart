import 'package:flutter/material.dart';
import 'package:workey/company_account/widgets/employee_sliver.dart';

import '../widgets/group_screen_widgets/opaque_image.dart';
import 'employee_detail_pages/employees_shifts_view.dart';
import 'employee_detail_pages/employees_info_view.dart';

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
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
            children: [
              SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      key: PageStorageKey<String>(EmployeesInfoView().getName),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.only(top: 8.0),
                          sliver: SliverToBoxAdapter(
                            child: Container(
                              height: 600,
                              child: EmployeesInfoView(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 130.0),
                child: EmployeesShiftsView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
