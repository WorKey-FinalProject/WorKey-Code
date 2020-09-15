import 'package:flutter/material.dart';
import './group_screen_widgets/opaque_image.dart';

class EmployeeSliver extends StatefulWidget {
  @override
  _EmployeeSliverState createState() => _EmployeeSliverState();
}

class _EmployeeSliverState extends State<EmployeeSliver> {
  ScrollController _scrollController;
  bool lastStatus = true;
  double height = 200;

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (height - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: height,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Row(
                    children: <Widget>[
                      CircleAvatar(
                        child: OpaqueImage(
                          imageUrl:
                              'https://pbs.twimg.com/profile_images/1192101281252495363/c_xL2w3j.jpg',
                        ),
                      ),
                      Text('data'),
                      Text('hello'),
                    ],
                  )
                  // : SingleChildScrollView(
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       crossAxisAlignment: CrossAxisAlignment.stretch,
                  //       children: <Widget>[
                  //         CircleAvatar(
                  //           child: OpaqueImage(
                  //             imageUrl:
                  //                 'https://pbs.twimg.com/profile_images/1192101281252495363/c_xL2w3j.jpg',
                  //           ),
                  //         ),
                  //         Text('data'),
                  //       ],
                  //     ),
                  //   ),
                  ),
            ),
          ];
        },
        body: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return Container(
              height: 40,
              child: Text(index.toString()),
            );
          },
        ),
      ),
    );
  }
}
