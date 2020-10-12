import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workey/personal_account/screens/shifts_screen.dart';

import '../widgets/employee_sliver.dart';
import '../../general/models/group_employee_model.dart';
import '../../general/providers/company_groups.dart';
import '../widgets/group_screen_widgets/opaque_image.dart';
import 'employee_detail_pages/employees_shifts_view.dart';
import 'employee_detail_pages/employees_info_view.dart';

class EmployeeDetailScreen extends StatefulWidget {
  final String employeesId;

  EmployeeDetailScreen(this.employeesId);

  @override
  _EmployeeDetailScreenState createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  GroupEmployeeModel currentEmployee;

  @override
  Widget build(BuildContext context) {
    final currentEmployee = Provider.of<CompanyGroups>(context, listen: false)
        .findEmployeeById(widget.employeesId);

    final List _tabs = [
      EmployeesInfoView(currentEmployee),
      ShiftsScreen(currentEmployee),
    ];

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
                    background: currentEmployee.picture.isEmpty
                        ? Center(
                            child: Text(
                              '${currentEmployee.firstName} ${currentEmployee.lastName}',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : OpaqueImage(imageUrl: currentEmployee.picture),
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
                      key: PageStorageKey<String>(
                          EmployeesInfoView(currentEmployee).getName),
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
                              height: 700,
                              child: EmployeesInfoView(currentEmployee),
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
                child: ShiftsScreen(currentEmployee),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
