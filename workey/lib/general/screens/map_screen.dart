import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/providers/company_groups.dart';
import 'package:workey/helpers/location_helper.dart';

class MapScreen extends StatefulWidget {
  final LatLng initialLocation;
  final bool isSelecting;

  MapScreen({
    this.initialLocation,
    this.isSelecting = false,
  });
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var _isLoadingSave = false;
  var _isLoadingLocation = false;

  LatLng _pickedLocation;
  LatLng _initialLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });
    final locData = await Location().getLocation();
    _initialLocation = LatLng(locData.latitude, locData.longitude);
    setState(() {
      _isLoadingLocation = false;
    });
  }

  @override
  void initState() {
    _getCurrentUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialLocation != null) {
      _initialLocation = widget.initialLocation;
    }
    final companyGroupsProvider =
        Provider.of<CompanyGroups>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        actions: [
          if (widget.isSelecting)
            _isLoadingSave
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : IconButton(
                    color: Theme.of(context).accentColor,
                    iconSize: 34,
                    icon: Icon(Icons.check),
                    onPressed: () async {
                      setState(() {
                        _isLoadingSave = true;
                      });
                      try {
                        await companyGroupsProvider
                            .setLocationToWorkGroup(_pickedLocation);
                      } catch (err) {
                        Fluttertoast.showToast(
                          msg: err,
                          backgroundColor: Colors.red,
                        );
                      }
                      Fluttertoast.showToast(
                        msg: 'Workgroup location saved',
                        backgroundColor: Colors.blue,
                      );

                      setState(() {
                        _isLoadingSave = false;
                      });
                    },
                  ),
        ],
      ),
      body: _isLoadingLocation
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialLocation,
                zoom: 16,
              ),
              onTap: widget.isSelecting ? _selectLocation : null,
              markers: _pickedLocation == null
                  ? null
                  : {
                      Marker(
                        markerId: MarkerId('work'),
                        position: _pickedLocation,
                      ),
                    },
            ),
    );
  }
}
