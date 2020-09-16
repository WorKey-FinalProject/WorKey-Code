import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:workey/general/models/feed_model.dart';
import 'package:workey/general/models/group_employee_model.dart';
import 'package:workey/general/models/work_group_model.dart';

import 'package:flutter/foundation.dart';

class CompanyGroups with ChangeNotifier {
  final dbRef = FirebaseDatabase.instance.reference();
  String userId;

  List<FeedModel> feedList = [];
  List<WorkGroupModel> workGroupsList = [];
  List<GroupEmployeeModel> employeeList = [];

  FeedModel feedModel = FeedModel(
    title: null,
  );

  WorkGroupModel workGroupModel = WorkGroupModel(
      workGroupName: null,
      managerId: null,
      parentWorkGroupId: null,
      dateOfCreation: null,
      workGroupLogo: null);

  GroupEmployeeModel groupEmployeeModel = GroupEmployeeModel(
    id: null,
    workGroupId: null,
  );

  List<FeedModel> get getFeedList {
    return [...feedList];
  }

  List<WorkGroupModel> get getWorkGroupsList {
    return [...workGroupsList];
  }

  List<GroupEmployeeModel> get getWorkGroupEmployeeList {
    return [...employeeList];
  }

  FeedModel findFeedById(String id) {
    return feedList.firstWhere((feed) => feed.id == id);
  }

  WorkGroupModel findWorkGroupById(String id) {
    return workGroupsList.firstWhere((workGroup) => workGroup.id == id);
  }

  GroupEmployeeModel findEmployeeById(String id) {
    return employeeList.firstWhere((employee) => employee.id == id);
  }

  Future<void> getUserId() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      userId = user.uid;
      //fatchAndSetToLists();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> fatchAndSetToLists() async {
    await fatchAndSetToListHandler('feedList');
    await fatchAndSetToListHandler('empolyeeList');
    await fatchAndSetToListHandler('workGroupsList');
  }

  Future<void> fatchAndSetToListHandler(String name) async {
    try {
      await dbRef
          .child('Company Groups')
          .child(userId)
          .child(name)
          .orderByKey()
          .once()
          .then((DataSnapshot dataSnapshot) {
        Map<dynamic, dynamic> list = dataSnapshot.value;
        if (name == 'feedList') {
          list.forEach((key, value) {
            feedModel.fromJsonToObject(value, key);
            feedList.add(feedModel);
          });
        } else if (name == 'empolyeeList') {
          list.forEach((key, value) {
            groupEmployeeModel.fromJsonToObject(value, key);
            employeeList.add(groupEmployeeModel);
          });
        } else if (name == 'workGroupsList') {
          list.forEach((key, value) {
            workGroupModel.fromJson(value, key);
            workGroupsList.add(workGroupModel);
          });
        } else {
          throw 'Error in fatchAndSetToListHandler function';
        }
        notifyListeners();
      });
    } on Exception {
      throw ErrorHint;
    }
  }

  // Future<void> addToFirebaseAndList(dynamic model) async {
  //   var db = dbRef.child('Company Groups').child(userId);
  //   if (model is FeedModel) {
  //     db.child('feedList');
  //     String newKey = db.push().key;
  //     await db.child(newKey).set(model.toJson());
  //     model.id = newKey;
  //     feedList.add(feedModel);
  //   } else if (model is WorkGroupModel) {
  //     db.child('workGroupsList');
  //   } else if (model is GroupEmployeeModel) {
  //   } else {
  //     throw 'Error in addToFirebaseAndList funcrion';
  //   }
  // }

  Future<void> addEmployeeToFirebaseAndList(
      GroupEmployeeModel groupEmployeeModel) async {
    try {
      dbRef
          .child('Company Groups')
          .child(userId)
          .child('empolyeeList')
          .child(groupEmployeeModel.id)
          .set(groupEmployeeModel.toJson());
      employeeList.add(groupEmployeeModel);
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> updateFeedInFirebaseAndList(List<FeedModel> newFeedList) async {
    var db = dbRef.child('Company Groups').child(userId).child('feedList');
    try {
      await db.remove();
      if (newFeedList.isNotEmpty) {
        newFeedList.forEach((feed) {
          db.child(feed.id).set(feed.toJson());
        });
      } else {
        throw 'the list is empty';
      }
      feedList = newFeedList;
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> addWorkGroupToFirebaseAndList(
      WorkGroupModel workGroupModel) async {
    var db =
        dbRef.child('Company Groups').child(userId).child('workGroupsList');
    try {
      String newKew = db.push().key;
      await db.child(newKew).set(workGroupModel.toJson());
      workGroupModel.id = newKew;
      workGroupsList.add(workGroupModel);
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> updateEmployee(GroupEmployeeModel groupEmployeeModel) async {
    try {
      dbRef
          .child("Company Groups")
          .child(userId)
          .child('empolyeeList')
          .child(groupEmployeeModel.id)
          .update(groupEmployeeModel.toJson());
      employeeList[employeeList
              .indexWhere((employee) => employee.id == groupEmployeeModel.id)] =
          groupEmployeeModel;
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> updateWorkGroup(WorkGroupModel workGroupModel) async {
    try {
      dbRef
          .child('Company Groups')
          .child(userId)
          .child('workGroupsList')
          .child(workGroupModel.id)
          .update(workGroupModel.toJson());
      workGroupsList[workGroupsList.indexWhere(
          (workGroup) => workGroup.id == workGroupModel.id)] = workGroupModel;
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> deleteEmployeeById(String employeeId) async {
    try {
      await dbRef
          .child("Company Groups")
          .child(userId)
          .child('empolyeeList')
          .child(employeeId)
          .remove();
      employeeList.removeWhere((employee) => employee.id == employeeId);
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> deleteWorkGroupById(String workGroupId) async {
    try {
      await dbRef
          .child('Company Groups')
          .child(userId)
          .child('workGroupsList')
          .child(workGroupId)
          .remove();
      workGroupsList.removeWhere((workGroup) => workGroup.id == workGroupId);
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  /*
  Future<void> fatchAndSetFeedInList() async {
    try {
      await dbRef
          .child('Company Groups')
          .child(userId)
          .child('feedList')
          .orderByKey()
          .once()
          .then((DataSnapshot dataSnapshot) {
        Map<dynamic, dynamic> list = dataSnapshot.value;
        list.forEach((key, value) {
          feedModel.fromJsonToObject(value, key);
          feedList.add(feedModel);
        });
        notifyListeners();
      });
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> fatchAndSetEmployeesInList() async {
    try {
      await dbRef
          .child('Company Groups')
          .child(userId)
          .child('empolyeeList')
          .orderByKey()
          .once()
          .then((DataSnapshot dataSnapshot) {
        Map<dynamic, dynamic> list = dataSnapshot.value;
        list.forEach((key, value) {
          groupEmployeeModel.fromJsonToObject(value, key);
          employeeList.add(groupEmployeeModel);
        });
        notifyListeners();
      });
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> fatchAndSetWorkGroupsInList() async {
    try {
      await dbRef
          .child('Company Groups')
          .child(userId)
          .child('workGroupsList')
          .orderByKey()
          .once()
          .then((DataSnapshot dataSnapshot) {
        Map<dynamic, dynamic> list = dataSnapshot.value;
        list.forEach((key, value) {
          workGroupModel.fromJson(value, key);
          workGroupsList.add(workGroupModel);
        });
        notifyListeners();
      });
    } on Exception {
      throw ErrorHint;
    }
  }
  */

  /*
  Future<void> addFeedToFirebaseAndList(FeedModel feedModel) async {
    var db = dbRef.child('Company Groups').child(userId).child('feedList');
    try {
      String newKey = db.push().key;
      await db.child(newKey).set(feedModel.toJson());
      feedModel.id = newKey;
      feedList.add(feedModel);
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> updateFeed(FeedModel feedModel) {
    try {
      dbRef
          .child('Company Groups')
          .child(userId)
          .child('feedList')
          .child(feedModel.id)
          .update(feedModel.toJson());
      feedList[feedList.indexWhere((feed) => feed.id == feedModel.id)] =
          feedModel;
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> deleteFeedById(String feedId) async {
    try {
      await dbRef
          .child('Company Groups')
          .child(userId)
          .child('feedList')
          .child(feedId)
          .remove();
      feedList.removeWhere((feed) => feed.id == feedId);
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }
    */
}
