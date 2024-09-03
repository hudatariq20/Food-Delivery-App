import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_service/models/place_autocomplete_model.dart';
import 'package:food_delivery_service/respositories/places/places_repository.dart';
import 'package:meta/meta.dart';

part 'autocomplete_event.dart';
part 'autocomplete_state.dart';

class AutocompleteBloc extends Bloc<AutocompleteEvent, AutocompleteState> {
  final PlacesRepository _placesRepository;
  StreamSubscription? streamSubscription;
  AutocompleteBloc({required PlacesRepository placesRepository})
      : _placesRepository = placesRepository,
        super(AutocompleteLoading()) {
    on<LoadAutocomplete>(_LoadAutocomplete);
    on<ClearAutoComplete>(_ClearAutoComplete);
  }

  void _LoadAutocomplete(
      LoadAutocomplete event, Emitter<AutocompleteState> emit) async {
    final List<PlaceAutocomplete> placeAutocomplete =
        await _placesRepository.getPlaceAutoComplete(event.searchInput);
    emit(AutocompleteLoaded(autocomplete: placeAutocomplete));
  }

  FutureOr<void> _ClearAutoComplete(
      ClearAutoComplete event, Emitter<AutocompleteState> emit) {
    emit(AutocompleteLoaded(autocomplete: List.empty()));
  }
}
