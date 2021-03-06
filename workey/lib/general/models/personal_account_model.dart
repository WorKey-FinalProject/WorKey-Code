import 'dart:io';

import 'package:flutter/foundation.dart';

class PersonalAccountModel {
  String id;
  String email;
  String firstName;
  String lastName;
  String dateOfCreation;
  String phoneNumber;
  String dateOfBirth;
  String address;
  String companyId;
  String faceRecognitionPicture;
  String fingerPrint;
  String token;
  String profilePicture;

  File imageFile;

  PersonalAccountModel({
    this.id,
    @required this.email,
    @required this.firstName,
    @required this.lastName,
    @required this.dateOfCreation,
    this.phoneNumber,
    this.dateOfBirth,
    this.companyId,
    this.address,
    this.faceRecognitionPicture,
    this.fingerPrint,
    this.profilePicture,
    @required this.token,
  });

  void addId(String id) {
    this.id = id;
  }

  void setImageFile(File file) {
    imageFile = file;
  }

  File get getImageFile {
    return imageFile;
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
      'faceRecognitionPicture': this.faceRecognitionPicture,
      'fingerPrint': this.fingerPrint,
      'profilePicture': this.profilePicture,
      'companyId': this.companyId,
      'token': this.token,
    };
  }

  void fromJsonToObject(Map snapshot, String uid) {
    id = uid;
    email = snapshot['email'];
    firstName = snapshot['firstName'];
    lastName = snapshot['lastName'];
    token = snapshot['token'];
    dateOfCreation = snapshot['dateOfCreation'];
    address = snapshot['address'] ?? '';
    dateOfBirth = snapshot['dateOfBirth'] ?? '';
    faceRecognitionPicture = snapshot['faceRecognitionPicture'] ?? '';
    phoneNumber = snapshot['phoneNumber'] ?? '';
    profilePicture = snapshot['profilePicture'] ?? '';
    fingerPrint = snapshot['fingerPrint'] ?? '';
    companyId = snapshot['companyId'] ?? '';
  }

  void updateUser(PersonalAccountModel personalUserModel) {
    this.address = personalUserModel.address;
    this.dateOfBirth = personalUserModel.dateOfBirth;
    this.dateOfCreation = personalUserModel.dateOfCreation;
    this.email = personalUserModel.email;
    this.faceRecognitionPicture = personalUserModel.faceRecognitionPicture;
    this.fingerPrint = personalUserModel.fingerPrint;
    this.firstName = personalUserModel.firstName;
    this.lastName = personalUserModel.lastName;
    this.phoneNumber = personalUserModel.phoneNumber;
    this.profilePicture = personalUserModel.profilePicture;
    this.companyId = personalUserModel.companyId;
  }
}
