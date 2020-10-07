import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:workey/general/models/company_account_model.dart';
import 'package:workey/general/models/group_employee_model.dart';
import 'package:workey/general/models/personal_account_model.dart';
import 'package:workey/general/models/work_group_model.dart';

import 'package:flutter/foundation.dart';

class CompanyGroups with ChangeNotifier {
  final _dbRef = FirebaseDatabase.instance.reference();
  String _userId;

  List<WorkGroupModel> _workGroupList = [];
  List<GroupEmployeeModel> _employeeList = [];

  WorkGroupModel _currentWorkGroup;

  String workGroupImagePath = 'workgroup_logo';

  List<WorkGroupModel> get getWorkGroupsList {
    return [..._workGroupList];
  }

  List<GroupEmployeeModel> get getEmployeeList {
    if (_currentWorkGroup != null) {
      return [
        ..._employeeList
            .where((employee) => employee.workGroupId == _currentWorkGroup.id)
      ].toList();
    }
    return [..._employeeList];
  }

  WorkGroupModel get getCurrentWorkGroup {
    return _currentWorkGroup;
  }

  WorkGroupModel findWorkGroupById(String id) {
    return _workGroupList.firstWhere((workGroup) => workGroup.id == id);
  }

  GroupEmployeeModel findEmployeeById(String id) {
    return _employeeList.firstWhere((employee) => employee.id == id);
  }

  Future<void> getUserId() async {
    try {
      User user = FirebaseAuth.instance.currentUser;
      _userId = user.uid;
      await deleteCompanyAccount();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> setPersonalCompanyIdInFirebase(
      String personalId, String companyId) async {
    try {
      await _dbRef
          .child('Users')
          .child('Personal Accounts')
          .child('personalId')
          .child('companyId')
          .set(companyId);
    } on Exception {
      throw 'Error in setPersonalCompanyId';
    }
  }

  Future<void> setCurrentWorkGroup(WorkGroupModel workGroupModel) async {
    _currentWorkGroup = workGroupModel;
    notifyListeners();
  }

  Future<String> getPersonalIdIfExistsByEmail(String email) async {
    String ans = 'null';
    try {
      await _dbRef
          .child('Users')
          .child('Personal Accounts')
          .orderByKey()
          .once()
          .then((DataSnapshot dataSnapshot) {
        Map<dynamic, dynamic> map = dataSnapshot.value;
        map.forEach((key, value) {
          if (value['email'] == email) {
            ans = key;
          }
        });
      });
    } on Exception {
      throw ErrorHint;
    }
    return ans;
  }

  Future<void> clearLists() async {
    _workGroupList = [];
    _employeeList = [];
  }

  Future<void> fetchAndSetToLists() async {
    User user = FirebaseAuth.instance.currentUser;
    _userId = user.uid;
    clearLists();
    await _fetchAndSetToListHandler('employeeList');
    await _fetchAndSetToListHandler('workGroupList');
    await _fetchGroupEmployeeData();
  }

  Future<void> _fetchAndSetToListHandler(String name) async {
    try {
      await _dbRef
          .child('Company Groups')
          .child(_userId)
          .child(name)
          .orderByKey()
          .once()
          .then((DataSnapshot dataSnapshot) {
        if (dataSnapshot.value != '') {
          Map<dynamic, dynamic> list = dataSnapshot.value;
          if (list != null) {
            if (name == 'employeeList') {
              list.forEach((key, value) {
                GroupEmployeeModel emp =
                    GroupEmployeeModel(id: null, workGroupId: null);
                emp.fromJsonToObject(value, key);
                _employeeList.add(emp);
              });
            } else if (name == 'workGroupList') {
              list.forEach((key, value) {
                WorkGroupModel wg = WorkGroupModel(
                    workGroupName: null,
                    managerId: null,
                    dateOfCreation: null,
                    logo: null);
                wg.fromJson(value, key);
                _workGroupList.add(wg);
              });
            } else {
              throw 'Error in fatchAndSetToListHandler function';
            }
            notifyListeners();
          }
        }
      });
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> fetchEmployeeData(GroupEmployeeModel groupEmployeeModel) async {
    await _dbRef
        .child('Users')
        .child('Personal Accounts')
        .child(groupEmployeeModel.id)
        .once()
        .then((DataSnapshot dataSnapshot) {
      PersonalAccountModel p = PersonalAccountModel(
          email: null, firstName: null, lastName: null, dateOfCreation: null);
      p.fromJsonToObject(dataSnapshot.value, groupEmployeeModel.id);
      groupEmployeeModel.address = p.address;
      groupEmployeeModel.firstName = p.firstName;
      groupEmployeeModel.lastName = p.lastName;
      groupEmployeeModel.phoneNumber = p.phoneNumber;
      groupEmployeeModel.picture = p.profilePicture;
      groupEmployeeModel.email = p.email;
    });
  }

  Future<void> _fetchGroupEmployeeData() async {
    try {
      if (_employeeList.isNotEmpty) {
        _dbRef
            .child('Users')
            .child('Personal Accounts')
            .orderByKey()
            .once()
            .then((DataSnapshot dataSnapshot) {
          Map<dynamic, dynamic> map = dataSnapshot.value;
          _employeeList.forEach((employee) {
            PersonalAccountModel p = PersonalAccountModel(
                email: null,
                firstName: null,
                lastName: null,
                dateOfCreation: null);
            p.fromJsonToObject(map[employee.id], employee.id);
            employee.firstName = p.firstName;
            employee.lastName = p.lastName;
            employee.phoneNumber = p.phoneNumber;
            employee.address = p.address;
            employee.picture = p.profilePicture;
          });
        });
      }
    } on Exception {
      throw 'Error in _fetchGroupEmployeeData()';
    }
    notifyListeners();
  }

  Future<void> addToFirebaseAndList(dynamic model) async {
    User user = FirebaseAuth.instance.currentUser;
    try {
      /// model == WorkGroupModel
      if (model is WorkGroupModel) {
        /// get db path & generate new Key
        var db = _dbRef
            .child('Company Groups')
            .child(_userId)
            .child('workGroupList');
        String newKey = db.push().key;
        model.id = newKey;

        /// Add workgroup logo to firebase-storage
        if (model.getImageFile != null) {
          final ref = FirebaseStorage.instance
              .ref()
              .child(workGroupImagePath)
              .child(user.uid)
              .child(model.id + '.jpg');
          await ref
              .putFile(
                model.imageFile,
              )
              .onComplete;
          print('File Uploaded');
          final url = await ref.getDownloadURL();
          model.logo = url;
        }

        /// Add model to Firebase-realtime & local-list
        await db.child(model.id).set(model.toJson());
        _workGroupList.add(model);

        /// model == GroupEmployeeModel
      } else if (model is GroupEmployeeModel) {
        model.entryDate = DateTime.now();
        await _dbRef
            .child('Company Groups')
            .child(_userId)
            .child('employeeList')
            .child(model.id)
            .set(model.toJson());
        _employeeList.add(model);
      } else {
        throw 'Error in addToFirebaseAndList function';
      }
    } on Exception {
      throw ErrorHint;
    }
    notifyListeners();
  }

  Future<void> updateInFirebaseAndList(dynamic model) async {
    try {
      var db = _dbRef.child('Company Groups').child(_userId);
      if (model is WorkGroupModel) {
        db.child('workGroupList');
        _workGroupList[_workGroupList
            .indexWhere((workGroup) => workGroup.id == model.id)] = model;
      } else if (model is GroupEmployeeModel) {
        db.child('employeeList');
        _employeeList[_employeeList
            .indexWhere((employee) => employee.id == model.id)] = model;
      } else {
        throw 'Error in updateInFirebaseAndList function';
      }
      db.child(model.id).update(model.toJson());
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> deleteEmployeeById(String employeeId, String workGroupId) async {
    GroupEmployeeModel groupEmployeeModel =
        GroupEmployeeModel(id: employeeId, workGroupId: workGroupId);
    try {
      await _dbRef
          .child("Company Groups")
          .child(_userId)
          .child('deletedEmployeeList')
          .child(employeeId)
          .set(groupEmployeeModel.toJson());
      await _dbRef
          .child("Company Groups")
          .child(_userId)
          .child('employeeList')
          .child(employeeId)
          .remove();
      _employeeList.removeWhere((employee) => employee.id == employeeId);
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<void> _addDeletedPersonalAccount(
      PersonalAccountModel personalAccountModel) async {
    try {
      await _dbRef
          .child('Users')
          .child('Deleted Personal Accounts')
          .child(personalAccountModel.id)
          .set(personalAccountModel.toJson());
    } on Exception {
      throw 'Error in _addDeletedPersonalAccount function';
    }
  }

  Future<void> deletePersonalAccount() async {
    try {
      await _dbRef
          .child('Users')
          .child('Personal Accounts')
          .child(_userId)
          .once()
          .then((DataSnapshot dataSnapshot) {
        PersonalAccountModel personalAccountModel = PersonalAccountModel(
          email: null,
          firstName: null,
          lastName: null,
          dateOfCreation: null,
        );
        personalAccountModel.fromJsonToObject(
            dataSnapshot.value, dataSnapshot.key);
        _addDeletedPersonalAccount(personalAccountModel);
      });
      await _dbRef
          .child('Users')
          .child('Personal Accounts')
          .child(_userId)
          .remove();
      User user = FirebaseAuth.instance.currentUser;
      await user.delete();
    } on Exception {
      throw 'Error in deletePersonalAccount function';
    }
  }

  Future<void> _addDeletedCompanyAccount(
      CompanyAccountModel companyAccountModel) async {
    try {
      await _dbRef
          .child('Users')
          .child('Deleted Company Accounts')
          .child(companyAccountModel.id)
          .set(companyAccountModel.toJson());
    } on Exception {
      throw 'Error in _addDeletedPersonalAccount function';
    }
  }

  Future<void> deleteCompanyAccount() async {
    try {
      await _dbRef
          .child('Users')
          .child('Company Accounts')
          .child(_userId)
          .once()
          .then((DataSnapshot dataSnapshot) {
        CompanyAccountModel companyAccountModel = CompanyAccountModel(
            companyEmail: null,
            companyName: null,
            owenrFirstName: null,
            owenrLastName: null,
            dateOfCreation: null);
        companyAccountModel.fromJsonToObject(
            dataSnapshot.value, dataSnapshot.key);
        _addDeletedCompanyAccount(companyAccountModel);
      });
      await _dbRef.child('Company Groups').child(_userId).remove();
      await _dbRef
          .child('Users')
          .child('Company Accounts')
          .child(_userId)
          .remove();
      User user = FirebaseAuth.instance.currentUser;
      await user.delete();
    } on Exception {
      throw 'Error in deleteCompanyAccount function';
    }
  }

  Future<void> deleteWorkGroup(WorkGroupModel workGroupModel) async {
    WorkGroupModel wg = WorkGroupModel(
        workGroupName: null,
        dateOfCreation: null,
        logo: null,
        id: workGroupModel.id);
    try {
      await _dbRef
          .child('Company Groups')
          .child(_userId)
          .child('workGroupList')
          .child(workGroupModel.id)
          .remove();
      await _dbRef
          .child('Company Groups')
          .child(_userId)
          .child('deletedWorkGroupList')
          .child(workGroupModel.id)
          .set(wg.toJson());
      workGroupModel.employeeList.forEach((employee) {
        deleteEmployeeById(employee.id, workGroupModel.id);
      });
      _workGroupList
          .removeWhere((workGroup) => workGroup.id == workGroupModel.id);
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }

  Future<List<PersonalAccountModel>> getAllPersonalAccounts() async {
    List<PersonalAccountModel> list = [];
    try {
      await _dbRef
          .child('Users')
          .child('Personal Accounts')
          .orderByKey()
          .once()
          .then((DataSnapshot dataSnapshot) {
        Map<dynamic, dynamic> map = dataSnapshot.value;
        map.forEach((key, value) {
          PersonalAccountModel p = PersonalAccountModel(
              email: null,
              firstName: null,
              lastName: null,
              dateOfCreation: null);
          p.fromJsonToObject(value, key);
          list.add(p);
        });
      });
    } on Exception {
      throw 'Error in getAllPersonalAccounts()';
    }
    return list;
  }
}
