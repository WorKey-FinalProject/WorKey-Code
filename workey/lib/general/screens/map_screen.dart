import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:workey/general/models/place_location.dart';
import 'package:workey/general/providers/company_groups.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen({
    this.initialLocation = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
    ),
    this.isSelecting = false,
  });
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var _isLoading = false;
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    final companyGroupsProvider =
        Provider.of<CompanyGroups>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        actions: [
          if (widget.isSelecting)
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : IconButton(
                    color: Theme.of(context).accentColor,
                    iconSize: 34,
                    icon: Icon(Icons.check),
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      await companyGroupsProvider
                          .setLocationToWorkGroup(_pickedLocation);
                      setState(() {
                        _isLoading = false;
                      });
                    },
                  ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
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
