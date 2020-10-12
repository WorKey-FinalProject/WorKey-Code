import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../general/models/work_group_model.dart';
import '../../general/providers/company_groups.dart';
import '../../general/screens/map_screen.dart';
import '../../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  WorkGroupModel _workGroupModel;
  String _previewImageUrl;
  var _isLoading = false;
  var _loadOnce = false;

  Future<void> _getCurrentUserLocation() async {
    setState(() {
      _isLoading = true;
    });
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: locData.latitude,
      longitude: locData.longitude,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
      _isLoading = false;
    });
  }

  Future<void> _getWorkGroupLocation() async {
    setState(() {
      _isLoading = true;
    });
    final locData = _workGroupModel.location;
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: locData.latitude,
      longitude: locData.longitude,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
      _isLoading = false;
    });
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MapScreen(
          initialLocation: _workGroupModel.location,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    // ...
  }

  // @override
  // void initState() {
  //   // _getCurrentUserLocation();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    _workGroupModel = Provider.of<CompanyGroups>(context).getCurrentWorkGroup;
    if (!_loadOnce) {
      if (_workGroupModel != null) {
        _getWorkGroupLocation();
      } else {
        Fluttertoast.showToast(msg: 'No location defined for workgroup');
        _getCurrentUserLocation();
      }
      _loadOnce = true;
    }

    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).primaryColor,
              // color: Colors.white,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: _isLoading
              ? CircularProgressIndicator()
              : _previewImageUrl == null
                  ? Text(
                      'No Location Chosen',
                      textAlign: TextAlign.center,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                      ),
                      child: Image.network(
                        _previewImageUrl,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 50,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: FittedBox(
                  child: FlatButton.icon(
                    icon: Icon(
                      Icons.location_on,
                    ),
                    label: Text('Current Location'),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _getCurrentUserLocation,
                  ),
                ),
              ),
              Flexible(
                child: FittedBox(
                  child: FlatButton.icon(
                    icon: Icon(
                      Icons.work,
                    ),
                    label: Text('Work Location'),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _getWorkGroupLocation,
                  ),
                ),
              ),
              Flexible(
                child: FittedBox(
                  child: FlatButton.icon(
                    icon: Icon(
                      Icons.map,
                    ),
                    label: Text('Select on Map'),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _selectOnMap,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
