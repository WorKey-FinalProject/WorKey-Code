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

  void fromJson(Map snapshot, String uid) {
    id = uid;
    companyEmail = snapshot['companyEmail'];
    companyName = snapshot['companyName'];
    owenrFirstName = snapshot['owenrFirstName'];
    owenrLastName = snapshot['owenrLastName'];
    dateOfCreation = snapshot['dateOfCreation'];
    location = snapshot['location'] ?? '';
    companyLogo = snapshot['companyLogo'] ?? '';
  }
}
