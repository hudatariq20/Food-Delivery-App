import 'package:flutter/material.dart';
import 'package:food_delivery_service/models/place_autocomplete_model.dart';
import 'package:food_delivery_service/respositories/places/base_places_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:food_delivery_service/models/places_model.dart';

class PlacesRepository extends BasePlacesRepository {
  final String key = 'AIzaSyC4rxfYWsQcAheHNbdhyfZTTSrUP8cyD0I';
  final String types = 'geocode';

  Future<List<PlaceAutocomplete>> getPlaceAutoComplete(
      String searchInput) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchInput&types=$types&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var result = json['predictions'] as List;
    print('//////////////////////////////////////');
    print(result);
    print('///////////////////////////////////////');
    return result.map((place) => PlaceAutocomplete.fromJson(place)).toList();
  }


  @override
  Future<Place> getPlace(String placeId) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;
    return Place.fromJson(results);
  }
}
