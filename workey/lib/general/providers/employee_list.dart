import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:workey/general/models/group_employee_model.dart';

class EmployeeList with ChangeNotifier {
  final _dbRef = FirebaseDatabase.instance.reference();
  String _userId;

  List<GroupEmployeeModel> _employeeList = [];

  List<GroupEmployeeModel> get getWorkGroupEmployeeList {
    return [..._employeeList];
  }

  GroupEmployeeModel findEmployeeById(String id) {
    return _employeeList.firstWhere((employee) => employee.id == id);
  }

  Future<void> clearList() async {
    _employeeList = [];
  }

  Future<void> fetchAndSetToList() async {
    User user = FirebaseAuth.instance.currentUser;
    _userId = user.uid;
    clearList();
    try {
      await _dbRef
          .child('Company Groups')
          .child(_userId)
          .child('feedList')
          .orderByKey()
          .once()
          .then((DataSnapshot dataSnapshot) {
        if (dataSnapshot.value != '') {
          Map<dynamic, dynamic> list = dataSnapshot.value;
          if (list != null) {
            list.forEach((key, value) {
              GroupEmployeeModel emp =
                  GroupEmployeeModel(id: null, workGroupId: null);
              emp.fromJsonToObject(value, key);
              _employeeList.add(emp);
            });
          }
        }
      });
    } on Exception {
      throw 'employee_list -> fetchAndSetToList() error';
    }
  }

  Future<void> addToFirebaseAndList(
      GroupEmployeeModel groupEmployeeModel) async {
    try {
      await _dbRef
          .child('Company Groups')
          .child(_userId)
          .child('empolyeeList')
          .child(groupEmployeeModel.id)
          .set(groupEmployeeModel.toJson());
      _employeeList.add(groupEmployeeModel);
    } on Exception {
      throw ErrorHint;
    }
    notifyListeners();
  }
}
