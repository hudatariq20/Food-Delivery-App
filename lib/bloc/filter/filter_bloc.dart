import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_service/models/category_filter.dart';
import 'package:food_delivery_service/models/filter_model.dart';
import 'package:food_delivery_service/models/price_filter.dart';
import 'package:http/http.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterLoading()) {
    on<LoadFilter>(_onLoadFilter);
    on<CategoryFilterUpdated>(_onUpdateCategoryFilter);
    on<PriceFilterUpdated>(_onUpdatePriceFilter);
  }

  void _onLoadFilter(LoadFilter event, Emitter<FilterState> emit) async {
    emit(FilterLoaded(
        filter: Filter(
            categoryFilter: CategoryFilter.filters,
            priceFilter: PriceFilter.filters)));
  }

  void _onUpdateCategoryFilter(
      CategoryFilterUpdated event, Emitter<FilterState> emit) {
    final state = this.state;
    if (state is FilterLoaded) {
      final List<CategoryFilter> updatedCategoryFilters =
          state.filter.categoryFilter.map((categoryFilter) {
        return categoryFilter.id == event.categoryFilter.id
            ? event.categoryFilter
            : categoryFilter;
      }).toList();

      emit(FilterLoaded(
          filter: Filter(
              categoryFilter: updatedCategoryFilters,
              priceFilter: state.filter.priceFilter)));
    }
    //var categories
  }

  void _onUpdatePriceFilter(
      PriceFilterUpdated event, Emitter<FilterState> emit) {
    var state = this.state;
    if (state is FilterLoaded) {
      final List<PriceFilter> updatedPriceFilters =
          state.filter.priceFilter.map((priceFilter) {
        return priceFilter.id == event.priceFilter.id
            ? event.priceFilter
            : priceFilter;
      }).toList();

      emit(FilterLoaded(
          filter: Filter(
              categoryFilter: state.filter.categoryFilter,
              priceFilter: updatedPriceFilters)));
    }
  }
}
