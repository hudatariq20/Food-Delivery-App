

import 'package:food_delivery_service/respositories/geolocation/base_geolocation_repository.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocationRepository extends BaseGeoLocationRepository {
  GeoLocationRepository();
  @override
  Future<Position> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location Not Available');
    } else {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    }
  }
}

  // @override
  // Future<Position?> getCurrentLocation() async {
  //   Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // }

