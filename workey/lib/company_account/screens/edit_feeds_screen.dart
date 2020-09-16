import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/models/feed_model.dart';
import 'package:workey/general/widgets/feed_item.dart';

import '../../general/providers/company_groups.dart';

class EditFeedsScreen extends StatefulWidget {
  @override
  _EditFeedsScreenState createState() => _EditFeedsScreenState();
}

class _EditFeedsScreenState extends State<EditFeedsScreen> {
  final titleTextController = TextEditingController();
  final textTextController = TextEditingController();

  @override
  void dispose() {
    titleTextController.dispose();
    textTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final feedProvider = Provider.of<CompanyGroups>(context);
    final feedList = feedProvider.getFeedList;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Feeds'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              feedProvider.updateFeedInFirebaseAndList(feedList);
            },
          )
        ],
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: feedList.map(
          (feed) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
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
      floatingActionButton: Container(
        height: 80,
        width: 80,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              addNewFeedItemShowDialog(context, _formKey, feedList);
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
          ),
        ),
      ),
    );
  }

  Future addNewFeedItemShowDialog(BuildContext context,
      GlobalKey<FormState> _formKey, List<FeedModel> feedList) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
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
                          if (value.length < 10) {
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
                              _formKey.currentState.save();
                              feedList.add(
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
              ],
            ),
          );
        });
  }
}
