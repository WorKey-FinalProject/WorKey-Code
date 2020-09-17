import 'package:flutter/foundation.dart';

class FeedModel {
  String id;
  String title;
  String text;

  FeedModel({
    this.id,
    @required this.title,
    this.text,
  });

  Map<String, Object> toJson() {
    return {
      'title': this.title,
      'description': this.text,
    };
  }

  void fromJsonToObject(Map snapshot, String uid) {
    id = uid;
    title = snapshot['title'];
    text = snapshot['description'] ?? '';
  }

  void updateFeed(FeedModel feedModel) {
    this.title = feedModel.title;
    this.text = feedModel.text;
  }
}
