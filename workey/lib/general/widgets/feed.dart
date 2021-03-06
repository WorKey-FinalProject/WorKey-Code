import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/providers/feed_list.dart';
import 'package:workey/general/widgets/auth/signup_type.dart';

import '../../general/providers/auth.dart';

import 'feed_item.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  int _current = 0;
  List<FeedItem> feedList;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final accountType = Provider.of<Auth>(context).accountType;
    final feedList = Provider.of<FeedList>(context).getFeedList;

    return LayoutBuilder(
      builder: (context, constraints) {
        return feedList.isEmpty
            ? accountType == AccountTypeChosen.company
                ? emptyListText(
                    'There are no feeds yet',
                    'To create a new feed click on \'Edit Feeds\' button',
                  )
                : emptyListText(
                    'There are no feeds yet',
                    'The feeds will appear according to the company manager',
                  )
            : feedList.length == 1
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 40.0),
                    child: FeedItem(
                      title: feedList[0].title,
                      text: feedList[0].text,
                    ),
                  )
                : Container(
                    height: constraints.maxHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: constraints.maxHeight * 0.9,
                          child: CarouselSlider(
                            options: CarouselOptions(
                              enlargeCenterPage: true,
                              autoPlay: true,
                              reverse: false,
                              autoPlayInterval: Duration(seconds: 5),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 2000),
                              pauseAutoPlayOnTouch: true,
                              scrollDirection: Axis.horizontal,
                              height: MediaQuery.of(context).size.height * 0.6,
                              initialPage: 0,
                              onPageChanged: (index, _) {
                                setState(() {
                                  _current = index;
                                });
                              },
                            ),
                            items: feedList.map(
                              (feed) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: FeedItem(
                                        title: feed.title,
                                        text: feed.text,
                                      ),
                                    );
                                  },
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          height: constraints.maxHeight * 0.09,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: map<Widget>(
                              feedList,
                              (index, _) {
                                return Container(
                                  width: _current == index ? 13 : 10,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _current == index
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
      },
    );
  }

  Column emptyListText(String title, String subTitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          subTitle,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
