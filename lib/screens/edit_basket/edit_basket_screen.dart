import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_service/bloc/basket/basket_bloc.dart';

class EditBasket extends StatelessWidget {
  const EditBasket({super.key});
  static const String routeName = '/edit-basket';

  static Route route() {
    return MaterialPageRoute(builder: ((_) => EditBasket()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Edit Basket',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: Colors.white)),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
        ),
        bottomNavigationBar: BottomAppBar(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder()),
                onPressed: () {},
                child: Text('Done'))
          ],
        )),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Items',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Theme.of(context).colorScheme.primary)),
              BlocBuilder<BasketBloc, BasketState>(
                builder: (context, state) {
                  if (state is BasketLoading) {
                    return CircularProgressIndicator();
                  } else if (state is BasketLoaded) {
                    return state.basket.menuItems.length == 0
                        ? Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 5),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'No items added in the basket',
                                    textAlign: TextAlign.left,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  )
                                ]),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.basket
                                .itemQuantity(state.basket.menuItems)
                                .keys
                                .length,
                            itemBuilder: ((context, index) {
                              return Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 5),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Row(
                                  children: [
                                    Text(
                                      '${state.basket.itemQuantity(state.basket.menuItems).entries.elementAt(index).value}x',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Text(
                                        '${state.basket.itemQuantity(state.basket.menuItems).keys.elementAt(index).name}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        context.read<BasketBloc>()
                                          ..add(RemoveAllItems(state.basket
                                              .itemQuantity(
                                                  state.basket.menuItems)
                                              .keys
                                              .elementAt(index)));
                                      },
                                      icon: Icon(Icons.delete),
                                      visualDensity: VisualDensity.compact,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        context.read<BasketBloc>()
                                          ..add(RemoveItem(state.basket
                                              .itemQuantity(
                                                  state.basket.menuItems)
                                              .keys
                                              .elementAt(index)));
                                      },
                                      icon: Icon(Icons.remove_circle),
                                      visualDensity: VisualDensity.compact,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        context.read<BasketBloc>()
                                          ..add(AddItem(state.basket
                                              .itemQuantity(
                                                  state.basket.menuItems)
                                              .keys
                                              .elementAt(index)));
                                      },
                                      icon: Icon(Icons.add_circle),
                                      visualDensity: VisualDensity.compact,
                                    )
                                  ],
                                ),
                              );
                            }));
                  } else {
                    return Text('Something went wrong');
                  }
                },
              ),
            ],
          ),
        ));
  }
}
