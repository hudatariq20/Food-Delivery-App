import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_service/models/places_model.dart';
import 'package:food_delivery_service/respositories/geolocation/geolocation_repository.dart';
import 'package:food_delivery_service/respositories/places/places_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GeoLocationRepository _geoLocationRepository;
  final PlacesRepository _placesRepository;
  StreamSubscription? _placesSubscription;
  StreamSubscription? _geoSubscription;
  LocationBloc(
      {required PlacesRepository placesRepository,
      required GeoLocationRepository geoLocationRepository})
      : _geoLocationRepository = geoLocationRepository,
        _placesRepository = placesRepository,
        super(LocationLoading()) {
    on<LoadMap>(_onLoadMap);
    on<SearchLocation>(_onSearchLocation);
  }

  void _onLoadMap(LoadMap event, Emitter<LocationState> emit) async {
    final Position position = await _geoLocationRepository.getCurrentLocation();
    print(position);
    emit(LocationLoaded(
        controller: event.controller,
        lat: position.latitude,
        lan: position.longitude));
  }

  void _onSearchLocation(
      SearchLocation event, Emitter<LocationState> emit) async {
    //update the camera position
    final state = this.state as LocationLoaded; //current location loaded..
    final Place place = await _placesRepository.getPlace(event.placeId);
    state.controller!
        .animateCamera(CameraUpdate.newLatLng(LatLng(place.lat, place.lon)));

    emit(LocationLoaded(
        controller: state.controller!, lat: place.lat, lan: place.lon));
  }

  @override
  Future<void> cancel() async {
    _placesSubscription?.cancel();
    _geoSubscription?.cancel();
    super.close();
  }
}
