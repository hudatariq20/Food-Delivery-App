part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

class LoadMap extends LocationEvent {
  final GoogleMapController? controller;

  LoadMap({this.controller});

  @override
  List<Object?> get props => [controller];
}

class SearchLocation extends LocationEvent {
  final String placeId;

  SearchLocation({required this.placeId});

   @override
  List<Object?> get props => [placeId];

}
