import 'package:flutter/foundation.dart';

class PersonalUserModel {
  String id;
  String email;
  String firstName;
  String lastName;
  String dateOfCreation;
  String phoneNumber;
  String dateOfBirth;
  String address;
  String occupation;
  String faceRecognitionPicture;
  String fingerPrint;
  String profilePicture;

  PersonalUserModel({
    this.id,
    @required this.email,
    @required this.firstName,
    @required this.lastName,
    @required this.dateOfCreation,
    this.phoneNumber,
    this.dateOfBirth,
    this.address,
    this.occupation,
    this.faceRecognitionPicture,
    this.fingerPrint,
    this.profilePicture,
  });

  void addId(String id) {
    this.id = id;
  }

  Map<String, Object> toJson() {
    return {
      'email': this.email,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'dateOfCreation': this.dateOfCreation,
      'phoneNumber': this.phoneNumber,
      'dateOfBirth': this.dateOfBirth,
      'address': this.address,
      'occupation': this.occupation,
      'faceRecognitionPicture': this.faceRecognitionPicture,
      'fingerPrint': this.fingerPrint,
      'profilePicture': this.profilePicture,
    };
  }

  void fromJson(Map snapshot, String uid) {
    id = uid;
    email = snapshot['email'];
    firstName = snapshot['firstName'];
    lastName = snapshot['lastName'];
    dateOfCreation = snapshot['dateOfCreation'];
    address = snapshot['address'] ?? '';
    dateOfBirth = snapshot['dateOfBirth'] ?? '';
    faceRecognitionPicture = snapshot['faceRecognitionPicture'] ?? '';
    occupation = snapshot['occupation'] ?? '';
    phoneNumber = snapshot['phoneNumber'] ?? '';
    profilePicture = snapshot['profilePicture'] ?? '';
    fingerPrint = snapshot['fingerPrint'] ?? '';
  }

  void updateUser(PersonalUserModel personalUserModel) {
    this.id = personalUserModel.id;
    this.address = personalUserModel.address;
    this.dateOfBirth = personalUserModel.dateOfBirth;
    this.dateOfCreation = personalUserModel.dateOfCreation;
    this.email = personalUserModel.email;
    this.faceRecognitionPicture = personalUserModel.faceRecognitionPicture;
    this.fingerPrint = personalUserModel.fingerPrint;
    this.firstName = personalUserModel.firstName;
    this.lastName = personalUserModel.lastName;
    this.occupation = personalUserModel.occupation;
    this.phoneNumber = personalUserModel.phoneNumber;
    this.profilePicture = personalUserModel.profilePicture;
  }
}
