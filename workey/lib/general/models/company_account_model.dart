import 'dart:io';

import 'package:flutter/foundation.dart';

class CompanyAccountModel {
  String id;
  String companyEmail;
  String companyName;
  String location;
  String companyLogo;
  String owenrFirstName;
  String owenrLastName;
  String dateOfCreation;

  File imageFile;

  CompanyAccountModel({
    this.id,
    @required this.companyEmail,
    @required this.companyName,
    this.location,
    this.companyLogo,
    @required this.owenrFirstName,
    @required this.owenrLastName,
    @required this.dateOfCreation,
  });

  void setImageFile(File file) {
    imageFile = file;
  }

  File get getImageFile {
    return imageFile;
  }

  Map<String, Object> toJson() {
    return {
      'companyEmail': this.companyEmail,
      'companyName': this.companyName,
      'location': this.location,
      'companyLogo': this.companyLogo,
      'owenrFirstName': this.owenrFirstName,
      'owenrLastName': this.owenrLastName,
      'dateOfCreation': this.dateOfCreation,
    };
  }

  void fromJsonToObject(Map snapshot, String uid) {
    id = uid;
    companyEmail = snapshot['companyEmail'];
    companyName = snapshot['companyName'];
    owenrFirstName = snapshot['owenrFirstName'];
    owenrLastName = snapshot['owenrLastName'];
    dateOfCreation = snapshot['dateOfCreation'];
    location = snapshot['location'] ?? '';
    companyLogo = snapshot['companyLogo'] ?? '';
  }

  void updateUser(CompanyAccountModel companyAccountModel) {
    this.companyEmail = companyAccountModel.companyEmail;
    this.companyName = companyAccountModel.companyName;
    this.companyLogo = companyAccountModel.companyLogo;
    this.location = companyAccountModel.location;
    this.owenrFirstName = companyAccountModel.owenrFirstName;
    this.owenrLastName = companyAccountModel.owenrLastName;
  }
}
