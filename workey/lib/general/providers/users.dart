// import 'dart:convert';

// import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;

// import 'package:workey/general/models/company_user_model.dart';
// import 'package:workey/general/models/personal_user_model.dart';

// class Users with ChangeNotifier {
//   List<PersonalUserModel> personalUserModelList = [];
//   List<CompanyUserModel> companyUserModelList = [];

//   List<PersonalUserModel> get personalUsersList {
//     return [...personalUserModelList];
//   }

//   List<CompanyUserModel> get companyUsersList {
//     return [...companyUserModelList];
//   }

//   Future<void> getUsersData(String path) async {
//     /* to use this function in 2 diffrent options:   (String path options: '' - all users data, '/CompanysUsers' or '/PersonalUsers')
//     var _isInit = true;
//     @override
//     void didChangeDependencies(){                            // runs before build few times.
//       if(_isInit){                                           // make sure this will run only 1 time.
//         Provider.of<Auth>(context).getUsersData('' or '/CompanysUsers' or '/PersonalUsers');
//       }
//       _isInit = false;
//       super.didChangeDependencies();
//     }

//     or
//     Provider.of<Auth>(context, listen: false).getUsersData('' or '/CompanysUsers' or '/PersonalUsers'); // for 1 time
//     */
//     final url = 'https://workey-8c645.firebaseio.com/Users$path.json';
//     try {
//       final response = await http.get(url);
//       final extractedData = json.decode(response.body) as Map<String, dynamic>;
//       if (path == '/CompanysUsers') {
//         final List<CompanyUserModel> loadedCompanysUsers = [];
//         extractedData.forEach((companyUserId, companyUserData) {
//           loadedCompanysUsers.add(CompanyUserModel(
//             id: companyUserId,
//             companyEmail: companyUserData['companyEmail'],
//             companyName: companyUserData['companyName'],
//             password: companyUserData['password'],
//             ceoFirstName: companyUserData['ceoFirstName'],
//             ceoLastName: companyUserData['ceoLastName'],
//             dateOfCreation: companyUserData['dateOfCreation'],
//             location: companyUserData['location'],
//             companyLogo: companyUserData['companyLogo'],
//           ));
//         });
//         print(companyUserModelList.length);
//         companyUserModelList = loadedCompanysUsers;
//         print(companyUserModelList.length);
//         notifyListeners();
//       } else {
//         final List<PersonalUserModel> loadedPersonalUsers = [];
//         extractedData.forEach((personalUserId, personalUserData) {
//           loadedPersonalUsers.add(PersonalUserModel(
//             id: personalUserId,
//             dateOfCreation: personalUserData['dateOfCreation'],
//             email: personalUserData['email'],
//             firstName: personalUserData['firstName'],
//             lastName: personalUserData['lastName'],
//             password: personalUserData['password'],
//             address: personalUserData['address'],
//             dateOfBirth: personalUserData['dateOfBirth'],
//             faceRecognitionPicture: personalUserData['faceRecognitionPicture'],
//             fingerPrint: personalUserData['fingerPrint'],
//             occupation: personalUserData['occupation'],
//             phoneNumber: personalUserData['phoneNumber'],
//             profilePicture: personalUserData['profilePicture'],
//           ));
//         });
//         personalUserModelList = loadedPersonalUsers;
//         notifyListeners();
//       }
//     } catch (err) {
//       throw (err);
//     }
//   }

//   void addPersonalUser(PersonalUserModel personalUserModel) {
//     const url = 'https://workey-8c645.firebaseio.com/Users/PersonalUsers.json';
//     http
//         .post(
//       url,
//       body: personalUserModel.personalModelToJson(),
//     )
//         .then((response) {
//       personalUserModel.addId(json.decode(response.body)['name']);
//       print(personalUserModel.id);
//     });
//   }

//   void addCompanyUser(CompanyUserModel companyUserModel) {
//     const url = 'https://workey-8c645.firebaseio.com/Users/CompanysUsers.json';
//     http
//         .post(
//       url,
//       body: companyUserModel.companyModelToJson(),
//     )
//         .then((response) {
//       companyUserModel.addId(json.decode(response.body)['name']);
//       print(companyUserModel.id);
//     });
//   }

//   // void deleteCompanyUser(String id) {
//   //   final url =
//   //       'https://workey-8c645.firebaseio.com/Users/CompanysUsers/$id.json';
//   //   http
//   //       .delete(
//   //     url,
//   //   )
//   //       .then((response) {
//   //     print("fck off");
//   //   });
//   // }
// }
