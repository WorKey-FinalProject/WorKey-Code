import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:workey/general/models/work_group_model.dart';

class WorkGroupList with ChangeNotifier {
  final _dbRef = FirebaseDatabase.instance.reference();
  String _userId;

  List<WorkGroupModel> _workGroupList = [];

  List<WorkGroupModel> get getWorkGroupsList {
    return [..._workGroupList];
  }

  WorkGroupModel findWorkGroupById(String id) {
    return _workGroupList.firstWhere((workGroup) => workGroup.id == id);
  }

  Future<void> clearList() async {
    _workGroupList = [];
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
              WorkGroupModel wg = WorkGroupModel(
                  workGroupName: null,
                  managerId: null,
                  dateOfCreation: null,
                  workGroupLogo: null);
              wg.fromJson(value, key);
              _workGroupList.add(wg);
            });
          }
        }
      });
    } on Exception {
      throw 'work_group_list -> fetchAndSetToList() error';
    }
  }

  Future<void> addToFirebaseAndList(WorkGroupModel workGroupModel) async {
    try {
      var db =
          _dbRef.child('Company Groups').child(_userId).child('workGroupList');
      String newKey = db.push().key;
      await db
          .child('workGroupList')
          .child(newKey)
          .set(workGroupModel.toJson());
      workGroupModel.id = newKey;
      _workGroupList.add(workGroupModel);
    } on Exception {
      throw ErrorHint;
    }
    notifyListeners();
  }
}
