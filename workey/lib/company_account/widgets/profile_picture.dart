import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart' as syspaths;

class ProfilePicture extends StatefulWidget {
  final Function onSelectImage;
  final double size;
  final bool isEditable;
  String imageUrl;
  File keepImageFile;

  ProfilePicture({
    @required this.onSelectImage,
    @required this.size,
    @required this.isEditable,
    @required this.imageUrl,
    this.keepImageFile,
  });

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File _pickedImage;
  ImageSource _imageSource;

  /// Enable ImagePicker for IOS !!
  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: _imageSource,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImage == null) {
      return;
    }
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
      widget.imageUrl = '';
    });

    widget.onSelectImage(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.keepImageFile != null) {
      _pickedImage = widget.keepImageFile;
    }
    return Container(
      alignment: Alignment.center,
      padding: widget.isEditable ? const EdgeInsets.all(16) : null,
      child: InkWell(
        borderRadius: BorderRadius.circular(90),
        onTap: () {
          return widget.isEditable ? choosePictureMethodDialog(context) : null;
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
                child: widget.imageUrl == ''
                    ? _pickedImage != null
                        ? Image.file(
                            _pickedImage,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          )
                        : widget.isEditable
                            ? Text('Add Image')
                            : Icon(
                                Icons.photo,
                                color: Colors.white,
                                size: widget.size * 0.3,
                              )
                    : CircleAvatar(
                        maxRadius: widget.size,
                        minRadius: widget.size,
                        backgroundImage: NetworkImage(
                          widget.imageUrl,
                        ),
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

  Future choosePictureMethodDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () {
                      _imageSource = ImageSource.camera;
                      _takePicture();
                      Navigator.of(context).pop();
                    },
                  ),
                  Text(
                    'Camera',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.wallpaper,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () {
                      _imageSource = ImageSource.gallery;
                      _takePicture();
                      Navigator.of(context).pop();
                    },
                  ),
                  Text(
                    'Gallery',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
