part of 'autocomplete_bloc.dart';

abstract class AutocompleteState extends Equatable {
  AutocompleteState();

  @override
  List<Object?> get props => [];
}

class AutocompleteLoading extends AutocompleteState {}

class AutocompleteLoaded extends AutocompleteState {
  final List<PlaceAutocomplete> autocomplete;

  AutocompleteLoaded({required this.autocomplete});

    @override
  List<Object?> get props => [autocomplete];

}

class AutoCompleteError extends AutocompleteState {}
