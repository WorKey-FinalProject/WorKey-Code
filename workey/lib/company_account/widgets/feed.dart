import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import './feed_item.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  int _current = 0;

  List<FeedItem> feeds = [
    FeedItem(
      title: 'one',
      text: 'oneeeeeeeeeeeeee',
    ),
    FeedItem(
      title: 'two',
      text: 'tweeeeeeeeeeeeee',
    ),
    FeedItem(
      title: 'three',
      text: 'threeeeeeeeeeeeee',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.5,
              initialPage: 0,
              onPageChanged: (index, _) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: feeds.map(
              (feed) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: feed,
                    );
                  },
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
