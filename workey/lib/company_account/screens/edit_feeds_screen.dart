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

  void _addNewFeed(FeedModel newFeedModel) {
    setState(() {
      feedList.add(newFeedModel);
    });
  }

  void _editFeed(FeedModel editedFeedModel) {
    setState(() {
      feedList[index] = editedFeedModel;
    });
  }

  int index;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final feedProvider = Provider.of<CompanyGroups>(context, listen: false);

    if (!_fetchListOnce) {
      feedList = feedProvider.getFeedList;
      _fetchListOnce = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Feeds'),
        actions: [
          Builder(
            builder: (ctx) {
              return IconButton(
                color: Theme.of(context).accentColor,
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
                      duration: Duration(seconds: 2),
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
      body: GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.6,
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
                child: GestureDetector(
                  onTap: () {
                    index =
                        feedList.indexWhere((element) => element.id == feed.id);
                    titleTextController.text = feed.title;
                    textTextController.text = feed.text;
                    feedItemShowDialog(context, _formKey, false);
                  },
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
                    height: 80,
                    width: 80,
                    child: FittedBox(
                      child: FloatingActionButton(
                        onPressed: () {},
                        child: Icon(Icons.delete),
                        backgroundColor: Colors.red,
                      ),
                    ),
                  )
                : Container(
                    height: 80,
                    width: 80,
                    child: FittedBox(
                      child: FloatingActionButton(
                        onPressed: () {
                          feedList.length < 10
                              ? feedItemShowDialog(context, _formKey, true)
                              : Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text(
                                      'There can be no more than 10 feeds',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    backgroundColor: Colors.orange,
                                  ),
                                );
                        },
                        child: Icon(Icons.add),
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Future feedItemShowDialog(
    BuildContext context,
    GlobalKey<FormState> _formKey,
    bool isNewItem,
  ) {
    if (isNewItem) {
      titleTextController.text = '';
      textTextController.text = '';
    }
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: titleTextController,
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
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: textTextController,
                      decoration: InputDecoration(
                        labelText: 'Text',
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
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        onPressed: () {
                          final isValid = _formKey.currentState.validate();
                          if (isValid) {
                            Navigator.pop(context);
                            _formKey.currentState.save();

                            isNewItem
                                ? _addNewFeed(
                                    FeedModel(
                                      title: titleTextController.text,
                                      text: textTextController.text,
                                    ),
                                  )
                                : _editFeed(
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
                        child: Text("Done"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
