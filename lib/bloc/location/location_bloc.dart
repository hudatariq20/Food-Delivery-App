import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_service/models/places_model.dart';
import 'package:food_delivery_service/respositories/geolocation/geolocation_repository.dart';
import 'package:food_delivery_service/respositories/local_storage/local_storage_repository.dart';
import 'package:food_delivery_service/respositories/places/places_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GeoLocationRepository _geoLocationRepository;
  final PlacesRepository _placesRepository;
  final LocalStorageRepository _localStorageRepository;
  StreamSubscription? _placesSubscription;
  StreamSubscription? _geoSubscription;

  LocationBloc(
      {required PlacesRepository placesRepository,
      required GeoLocationRepository geoLocationRepository,
      required LocalStorageRepository localStorageRepository})
      : _localStorageRepository = localStorageRepository,
        _geoLocationRepository = geoLocationRepository,
        _placesRepository = placesRepository,
        super(LocationLoading()) {
    on<LoadMap>(_onLoadMap);
    on<SearchLocation>(_onSearchLocation);
  }

  void _onLoadMap(LoadMap event, Emitter<LocationState> emit) async {
    Box box = await _localStorageRepository.openBox();
    Place? place = await _localStorageRepository.getPlace(box);
    if (place == null) {
      print('place is null');
      final Position location =
          await _geoLocationRepository.getCurrentLocation();
      emit(LocationLoaded(
          controller: event.controller,
          place: Place(lat: location.latitude, lon: location.longitude)));
    } else {
      emit(LocationLoaded(controller: event.controller, place: place));
    }
  }

  void _onSearchLocation(
      SearchLocation event, Emitter<LocationState> emit) async {
    final state = this.state as LocationLoaded; //current location loaded..
    final Place place = await _placesRepository.getPlace(event.placeId);

    if (place == null) {
      emit(LocationLoaded(controller: state.controller!, place: state.place));
    } else {
      Box box = await _localStorageRepository.openBox();
      _localStorageRepository.closeBox(box); //clear the box
      _localStorageRepository.addPlace(box, place);
      state.controller!
          .animateCamera(CameraUpdate.newLatLng(LatLng(place.lat, place.lon)));
      emit(LocationLoaded(controller: state.controller!, place: state.place));
    }
  }

  @override
  Future<void> cancel() async {
    _placesSubscription?.cancel();
    _geoSubscription?.cancel();
    super.close();
  }
}
