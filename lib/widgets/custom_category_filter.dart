import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_service/bloc/filter/filter_bloc.dart';
import 'package:food_delivery_service/models/category_model.dart';

class CustomCategoryFilter extends StatelessWidget {
  //final List<Category> categories;
  const CustomCategoryFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        if (state is FilterLoading) {
          return CircularProgressIndicator();
        } else if (state is FilterLoaded) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: state.filter.categoryFilter.length,
              itemBuilder: ((context, index) {
                return Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.filter.categoryFilter[index].category.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        SizedBox(
                            height: 25,
                            child: Checkbox(
                              onChanged: (value) {
                                context.read<FilterBloc>().add(
                                    CategoryFilterUpdated(
                                        categoryFilter: state.filter
                                            .categoryFilter[index]
                                            .copyWith(value : !state.filter.categoryFilter[index].value)));
                              },
                              value: state.filter.categoryFilter[index].value,
                            ))
                      ],
                    ));
              }));
        } else {
          return Text('Something went wrong');
        }
      },
    );
  }
}
