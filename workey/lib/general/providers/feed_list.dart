import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:workey/general/models/feed_model.dart';

class FeedList with ChangeNotifier {
  final _dbRef = FirebaseDatabase.instance.reference();
  String _userId;

  List<FeedModel> _feedList = [];

  List<FeedModel> get getFeedList {
    return [..._feedList];
  }

  FeedModel findFeedById(String id) {
    return _feedList.firstWhere((feed) => feed.id == id);
  }

  Future<void> clearList() async {
    _feedList = [];
  }

  Future<void> fetchAndSetToList() async {
    User user = FirebaseAuth.instance.currentUser;
    _userId = user.uid;
    clearList();
    try {
      await _dbRef
          .child('Company Groups')
          .child(_userId)
          .child('feedList')
          .orderByKey()
          .once()
          .then((DataSnapshot dataSnapshot) {
        if (dataSnapshot.value != '') {
          Map<dynamic, dynamic> list = dataSnapshot.value;
          if (list != null) {
            list.forEach((key, value) {
              FeedModel feed = FeedModel(title: null);
              feed.fromJsonToObject(value, key);
              _feedList.add(feed);
            });
          }
        }
      });
    } on Exception {
      throw 'feed_list -> fetchAndSetToList() error';
    }
  }

  Future<void> updateFeed(List<FeedModel> newFeedList) async {
    try {
      var db = _dbRef.child('Company Groups').child(_userId).child('feedList');
      await db.remove();
      if (newFeedList.isNotEmpty) {
        newFeedList.forEach((feed) {
          if (feed.id == null) {
            String newKey = db.push().key;
            db.child(newKey).set(feed.toJson());
            feed.id = newKey;
          } else {
            db.child(feed.id).set(feed.toJson());
          }
        });
      } else {
        newFeedList = [];
      }
      _feedList = newFeedList;
      notifyListeners();
    } on Exception {
      throw ErrorHint;
    }
  }
}
