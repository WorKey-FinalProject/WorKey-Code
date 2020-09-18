import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/models/feed_model.dart';
import 'package:workey/general/widgets/feed_item.dart';

import '../../general/providers/company_groups.dart';

class EditFeedsScreen extends StatefulWidget {
  @override
  _EditFeedsScreenState createState() => _EditFeedsScreenState();
}

class _EditFeedsScreenState extends State<EditFeedsScreen> {
  var _fetchListOnce = false;
  List<FeedModel> feedList = [];
  final titleTextController = TextEditingController();
  final textTextController = TextEditingController();
  var _isDragging = false;

  @override
  void dispose() {
    titleTextController.dispose();
    textTextController.dispose();
    super.dispose();
  }

  void _addNewFeed(FeedModel feedModel) {
    setState(() {
      feedList.add(feedModel);
    });
  }

  //Drag and Drop Vars
  int pos;
  List<FeedModel> _tmpList;
  ScrollController _scrollController;
  bool _initTmpListOnce = false;

  int index;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final feedProvider = Provider.of<CompanyGroups>(context, listen: false);

    if (!_fetchListOnce) {
      feedList = feedProvider.getFeedList;
      _fetchListOnce = true;
    }

    if (_initTmpListOnce == false) {
      _tmpList = [...feedList];
      _initTmpListOnce = !_initTmpListOnce;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Feeds'),
        actions: [
          Builder(
            builder: (ctx) {
              return IconButton(
                icon: Icon(Icons.save),
                onPressed: () async {
                  try {
                    await feedProvider.updateFeedInFirebaseAndList(feedList);
                  } on PlatformException catch (err) {
                    var message = 'An error occurred';

                    if (err.message != null) {
                      message = err.message;
                    }

                    Scaffold.of(ctx).showSnackBar(
                      SnackBar(
                        content: Text(message),
                        backgroundColor: Theme.of(context).errorColor,
                      ),
                    );
                  } catch (err) {
                    print(err);
                  }
                  Scaffold.of(ctx).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Changes saved successfully',
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: Colors.blue,
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
      backgroundColor: Colors.white.withOpacity(0.95),
      //body: buildDragAndDropGridView(),
      body: GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 5,
        ),
        children: feedList.map(
          (feed) {
            return LayoutBuilder(
              builder: (context, constraints) => LongPressDraggable(
                onDragStarted: () {
                  index =
                      feedList.indexWhere((element) => element.id == feed.id);
                  setState(() {
                    _isDragging = true;
                  });
                },
                onDragEnd: (details) {
                  setState(() {
                    _isDragging = false;
                  });
                },
                childWhenDragging: Text(''),
                feedback: Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  margin: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: FeedItem(
                    title: feed.title,
                    text: feed.text,
                  ),
                ),
                child: Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  margin: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: FeedItem(
                    title: feed.title,
                    text: feed.text,
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),

      floatingActionButton: DragTarget(
        onAccept: (data) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to delete this feed?'),
              actions: [
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () {
                    print(feedList[index].toJson());
                    setState(() {
                      feedList.removeAt(index);
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
        builder: (context, candidateData, rejectedData) {
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 400),
            child: _isDragging
                ? Container(
                    height: 90,
                    width: 90,
                    child: FittedBox(
                      child: FloatingActionButton(
                        onPressed: () {},
                        child: Icon(Icons.delete),
                        backgroundColor: Colors.red,
                      ),
                    ),
                  )
                : Container(
                    height: 90,
                    width: 90,
                    child: FittedBox(
                      child: FloatingActionButton(
                        onPressed: () {
                          addNewFeedItemShowDialog(context, _formKey);
                        },
                        child: Icon(Icons.add),
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ),
          );
        },
        // child: Container(
        //   height: 90,
        //   width: 90,
        //   child: FittedBox(
        //     child: FloatingActionButton(
        //       onPressed: () {
        //         addNewFeedItemShowDialog(context, _formKey);
        //       },
        //       child: _isDragging ? Icon(Icons.delete) : Icon(Icons.add),
        //       backgroundColor: _isDragging ? Colors.red : Colors.green,
        //     ),
        //   ),
        // ),
      ),
    );
  }

  DragAndDropGridView buildDragAndDropGridView() {
    return DragAndDropGridView(
      controller: _scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 5,
      ),
      padding: EdgeInsets.all(5),
      itemBuilder: (context, index) {
        return Opacity(
          opacity: pos != null ? pos == index ? 0.6 : 1 : 1,
          child: Container(
            width: 200,
            height: 350,
            margin: EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: FeedItem(
              title: feedList[index].title,
              text: feedList[index].text,
            ),
          ),
        );
      },
      itemCount: feedList.length,
      onWillAccept: (oldIndex, newIndex) {
        setState(() {
          _isDragging = true;
        });
        feedList = [...feedList];
        int indexOfFirstItem = feedList.indexOf(feedList[oldIndex]);
        int indexOfSecondItem = feedList.indexOf(feedList[newIndex]);

        if (indexOfFirstItem > indexOfSecondItem) {
          for (int i = feedList.indexOf(feedList[oldIndex]);
              i > feedList.indexOf(feedList[newIndex]);
              i--) {
            var tmp = feedList[i - 1];
            feedList[i - 1] = feedList[i];
            feedList[i] = tmp;
          }
        } else {
          for (int i = feedList.indexOf(feedList[oldIndex]);
              i < feedList.indexOf(feedList[newIndex]);
              i++) {
            var tmp = feedList[i + 1];
            feedList[i + 1] = feedList[i];
            feedList[i] = tmp;
          }
        }

        setState(
          () {
            pos = newIndex;
          },
        );

        return true;
      },
      onReorder: (oldIndex, newIndex) {
        setState(() {
          _isDragging = false;
        });
        feedList = [..._tmpList];
        int indexOfFirstItem = feedList.indexOf(feedList[oldIndex]);
        int indexOfSecondItem = feedList.indexOf(feedList[newIndex]);

        if (indexOfFirstItem > indexOfSecondItem) {
          for (int i = feedList.indexOf(feedList[oldIndex]);
              i > feedList.indexOf(feedList[newIndex]);
              i--) {
            var tmp = feedList[i - 1];
            feedList[i - 1] = feedList[i];
            feedList[i] = tmp;
          }
        } else {
          for (int i = feedList.indexOf(feedList[oldIndex]);
              i < feedList.indexOf(feedList[newIndex]);
              i++) {
            var tmp = feedList[i + 1];
            feedList[i + 1] = feedList[i];
            feedList[i] = tmp;
          }
        }
        _tmpList = [...feedList];
        setState(
          () {
            pos = null;
          },
        );
      },
    );
  }

  Future addNewFeedItemShowDialog(
    BuildContext context,
    GlobalKey<FormState> _formKey,
  ) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: const OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        titleTextController.text = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Description',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: const OutlineInputBorder(),
                    ),
                    maxLines: 10,
                    keyboardType: TextInputType.multiline,
                    onSaved: (value) {
                      textTextController.text = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a description.';
                      }
                      if (value.length < 5) {
                        return 'Should be at least 10 characters long.';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: () {
                        final isValid = _formKey.currentState.validate();
                        if (isValid) {
                          Navigator.pop(context);
                          _formKey.currentState.save();

                          _addNewFeed(
                            FeedModel(
                              title: titleTextController.text,
                              text: textTextController.text,
                            ),
                          );
                        }
                      },
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text("Submit"),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
