import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import './feed_item.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  int _current = 0;
  List<FeedItem> feedsList = [
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

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              enlargeCenterPage: true,
              autoPlay: true,
              reverse: false,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 2000),
              pauseAutoPlayOnTouch: true,
              scrollDirection: Axis.horizontal,
              height: MediaQuery.of(context).size.height * 0.5,
              initialPage: 0,
              onPageChanged: (index, _) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: feedsList.map(
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
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(feedsList, (index, _) {
              return Container(
                width: 10,
                height: 10,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Colors.redAccent : Colors.green,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
