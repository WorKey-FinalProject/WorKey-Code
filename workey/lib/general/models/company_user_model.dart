import 'package:flutter/foundation.dart';
import 'dart:convert';

class CompanyUserModel {
  String id;
  final String companyEmail;
  final String companyName;
  final String location;
  final String password;
  final String companyLogo;
  final String ceoFirstName;
  final String ceoLastName;
  final String dateOfCreation;

  CompanyUserModel({
    this.id,
    @required this.companyEmail,
    @required this.companyName,
    this.location,
    @required this.password,
    this.companyLogo,
    @required this.ceoFirstName,
    @required this.ceoLastName,
    @required this.dateOfCreation,
  });

  void addId(String id) {
    this.id = id;
  }

  String companyModelToJson() {
    return json.encode({
      'companyEmail': this.companyEmail,
      'companyName': this.companyName,
      'location': this.location,
      'password': this.password,
      'companyLogo': this.companyLogo,
      'ceoFirstName': this.ceoFirstName,
      'ceoLastName': this.ceoLastName,
      'dateOfCreation': this.dateOfCreation,
    });
  }
}
