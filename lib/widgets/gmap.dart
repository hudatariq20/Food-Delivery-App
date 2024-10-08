import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Gmap extends StatelessWidget {
  final double lat;
  final double lng;
  const Gmap({
    Key? key, 
    required this.lat, 
    required this.lng,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: GoogleMap(
          myLocationButtonEnabled: true,
          initialCameraPosition:
              CameraPosition(target: LatLng(lat,lng), zoom: 5)),
    );
  }
}
