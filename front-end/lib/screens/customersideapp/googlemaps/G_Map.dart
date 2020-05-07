// code adapted from https://github.com/rajayogan/flutter-googlemaps
//
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class G_Map extends StatefulWidget {
  final double latitude;
  final double longitude;
  const G_Map(this.latitude, this.longitude);
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<G_Map> {
  List<Marker> Allmarkers = [];
  var data = new Map();
  GoogleMapController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Allmarkers.add(Marker(
      markerId: MarkerId('0'),
      draggable: false,
      // onTap: () {
      //   print("this is marker");
      // },
      position: LatLng(widget.latitude, widget.longitude),
    ));
    data = {"latitude": widget.latitude, "longitude": widget.longitude};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Center(
          child: Text("Location"),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 2.0, 8.0, 2.0),
            child: IconButton(
              onPressed: () => {Navigator.pop(context, data)},
              icon: Icon(Icons.done),
              alignment: Alignment.center,
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.latitude, widget.longitude),
                zoom: 18.0,
              ),
              markers: Set.from(Allmarkers),
              onMapCreated: mapCreated,
              onTap: (LatLng point) => {
                    _handleTap(point),
                    data = {
                      "latitude": point.latitude,
                      "longitude": point.longitude
                    },
                    print(data),
                  }),
        ),
      ),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  _handleTap(LatLng point) {
    setState(() {
      Allmarkers.clear();
      Allmarkers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      ));
    });
  }
}
