import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/models/monthly_shift_summery_model.dart';
import 'package:workey/general/providers/monthly_shift_summery_list.dart';

class MonthlySummaryScreen extends StatelessWidget {
  Double monthSalary;
  Double monthHours;
  List<MonthlyShiftSummeryModel> temp;

  @override
  Widget build(BuildContext context) {
    final a = Provider.of<MonthltShiftSummeryList>(context, listen: false)
        .getFeedList;
    if (a != null && a.length == 1) {
      print(a[0].totalHours);
      print(a[0].totalWage);
    }
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 10.0),
            child: Text('Monthly Summary'),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Divider(
              thickness: 2.0,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.monetization_on_rounded,
                    size: 40.0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('salary'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.timer,
                    size: 40.0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('hours'),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
