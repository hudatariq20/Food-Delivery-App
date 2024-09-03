import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_service/bloc/filter/filter_bloc.dart';

class CustomPriceFilter extends StatelessWidget {
  //final List<Price> prices;
  const CustomPriceFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        if (state is FilterLoading) {
          return CircularProgressIndicator();
        } else if (state is FilterLoaded) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: state.filter.priceFilter
                  .asMap()
                  .entries
                  .map((price) => InkWell(
                        onTap: (() {
                          context.read<FilterBloc>().add(
                              PriceFilterUpdated(
                                priceFilter: 
                                state.filter.priceFilter[price.key].copyWith(
                                 value :   !state.filter.priceFilter[price.key].value
                                )));
                        }),
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(5.0),
                            color: state.filter.priceFilter[price.key].value ?
                            Theme.of(context).colorScheme.primary.withAlpha(100) :
                            Colors.white,
                          ),
                          child: Text(
                            state.filter.priceFilter[price.key].price.price,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ))
                  .toList());
        } else {
          return Text('Something went wrong');
        }
      },
    );
  }
}
