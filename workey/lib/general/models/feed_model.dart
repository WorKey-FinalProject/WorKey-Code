import 'package:flutter/foundation.dart';

class FeedModel {
  String id;
  String title;
  String description;

  FeedModel({
    this.id,
    @required this.title,
    this.description,
  });

  Map<String, Object> toJson() {
    return {
      'title': this.title,
      'description': this.description,
    };
  }

  void fromJsonToObject(Map snapshot, String uid) {
    id = uid;
    title = snapshot['title'];
    description = snapshot['description'] ?? '';
  }

  void updateFeed(FeedModel feedModel) {
    this.title = feedModel.title;
    this.description = feedModel.description;
  }
}
