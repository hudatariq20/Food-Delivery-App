import 'package:hive/hive.dart';

import '../../models/places_model.dart';

abstract class BaseLocalStorageRepository {
  Future<Box> openBox();
  Place? getPlace(Box box);
  Future<void> addPlace(Box box, Place place);
  Future<void> closeBox(Box box);
}
