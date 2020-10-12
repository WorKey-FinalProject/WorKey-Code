import 'package:flutter/cupertino.dart';
import 'package:workey/general/models/shift_model.dart';

class MonthlyShiftSummeryModel {
  String id;
  List<ShiftModel> shiftList;
  double totalHours;
  double totalWage;

  MonthlyShiftSummeryModel({
    this.id,
    @required this.shiftList,
    this.totalHours,
    this.totalWage,
  });

  Map<String, Object> toJson() {
    return {
      'totalHours': this.totalHours.toString(),
      'totalWage': this.totalWage.toString(),
    };
  }

  void fromJsonToObject(Map snapshot, String uid) {
    id = uid;
    totalHours = double.parse(snapshot['totalHours']);
    totalWage = double.parse(snapshot['totalHours']);
  }
}
