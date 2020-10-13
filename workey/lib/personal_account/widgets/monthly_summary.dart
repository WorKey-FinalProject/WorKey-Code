import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/providers/company_groups.dart';
import 'package:workey/general/providers/monthly_shift_summery_list.dart';
import 'package:workey/personal_account/screens/monthly_summary_screen.dart';

class MonthlySummary extends StatelessWidget {
  final Color backgroundColor;
  final Text buttonText;
  final Color iconColor;
  final Alignment iconAlignment;

  MonthlySummary({
    this.backgroundColor = Colors.redAccent,
    this.buttonText = const Text("REQUIRED TEXT"),
    this.iconColor,
    this.iconAlignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    final currentGroup =
        Provider.of<CompanyGroups>(context).getCurrentWorkGroup;
    return Container(
      color: Colors.blueGrey[50],
      child: FlatButton(
        onPressed: () {
          var _height = MediaQuery.of(context).size.height * 0.4;
          final summaryData =
              Provider.of<MonthltShiftSummeryList>(context, listen: false)
                  .getMonthlyShiftSummeryList;
          showModalBottomSheet(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            context: context,
            builder: (_) {
              return StatefulBuilder(
                builder: (context, _) {
                  return ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    child: Container(
                      height: _height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                      ),
                      child: MonthlySummaryScreen(summaryData),
                    ),
                  );
                },
              );
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: backgroundColor,
          ),
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          padding: const EdgeInsets.only(left: 10.0, right: 20.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
                      child: buttonText,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 60,
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Icon(Icons.data_usage_rounded),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
