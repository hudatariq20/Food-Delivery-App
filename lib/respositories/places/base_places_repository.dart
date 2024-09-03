import 'package:food_delivery_service/models/place_autocomplete_model.dart';

abstract class BasePlacesRepository{

  Future<List<PlaceAutocomplete>?>  getPlaceAutoComplete (String searchInput) async{}

}