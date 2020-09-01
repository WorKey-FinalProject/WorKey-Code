import 'package:flutter/foundation.dart';
import 'dart:convert';

class PersonalUserModel {
  String id;
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String dateOfCreation;
  final int phoneNumber;
  final String dateOfBirth;
  final String address;
  final String occupation;
  final String faceRecognitionPicture;
  final String fingerPrint;
  final String profilePicture;

  PersonalUserModel({
    this.id,
    @required this.email,
    @required this.firstName,
    @required this.lastName,
    @required this.password,
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

  String personalModelToJson() {
    return json.encode({
      'email': this.email,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'password': this.password,
      'dateOfCreation': this.dateOfCreation,
      'phoneNumber': this.phoneNumber,
      'dateOfBirth': this.dateOfBirth,
      'address': this.address,
      'occupation': this.occupation,
      'faceRecognitionPicture': this.faceRecognitionPicture,
      'fingerPrint': this.fingerPrint,
      'profilePicture': this.profilePicture,
    });
  }
}
