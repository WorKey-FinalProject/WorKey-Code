import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ProfilePicture extends StatefulWidget {
  final Function onSelectImage;
  final double size;
  final bool isEditable;

  ProfilePicture({
    this.onSelectImage,
    this.size,
    this.isEditable,
  });

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File _storedImage;

  /// Enable ImagePicker for IOS !!
  Future<void> _takePicture() async {
    // final picker = ImagePicker();
    // final imageFile = await picker.getImage(
    //   source: ImageSource.camera,
    //   maxWidth: 600,
    // );
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: widget.isEditable ? const EdgeInsets.all(16) : null,
      child: InkWell(
        borderRadius: BorderRadius.circular(90),
        onTap: () {
          return widget.isEditable
              ? showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.add_a_photo,
                              color: Theme.of(context).accentColor,
                            ),
                            onPressed: null,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.wallpaper,
                              color: Theme.of(context).accentColor,
                            ),
                            onPressed: null,
                          ),
                        ],
                      ),
                    );
                  },
                )
              : null;
        },
        child: Stack(
          children: [
            Container(
              height: widget.size,
              width: widget.size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4,
                  color: Colors.white,
                ),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1),
                  )
                ],
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(96.0),
                // child: widget.imageUrl == ''
                //     ? Text('Add Image')
                //     : Image.network(
                //         widget.imageUrl,
                //       ),
                child: _storedImage != null
                    ? Image.file(
                        _storedImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : widget.isEditable
                        ? Text('Add Image')
                        : Text(
                            'No Image Found',
                            style: TextStyle(fontSize: widget.size * 0.1),
                          ),
              ),
            ),
            if (widget.isEditable)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 4,
                      color: Colors.white,
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
