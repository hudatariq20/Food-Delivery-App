import 'package:food_delivery_service/models/places_model.dart';
import 'package:food_delivery_service/respositories/local_storage/base_local_storage_respository.dart';
import 'package:hive/hive.dart';

class LocalStorageRepository extends BaseLocalStorageRepository {
  final String _boxName = 'placesBox';
  Type boxType = Place;

  @override
  Future<Box> openBox() async {
    Box _box = await Hive.openBox<Place>(_boxName);
    return _box;
  }

  @override
  Place? getPlace(Box box) {
    if (box.values.length > 0) {
      return box.values.first as Place;
    }
  }

  @override
  Future<void> addPlace(Box box, Place place) async {
    await box.put(place.placeId, place);
  }

  @override
  Future<void> closeBox(Box box) async {
    await box.clear();
  }
}
