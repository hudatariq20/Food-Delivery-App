import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery_service/bloc/basket/basket_bloc.dart';

class Basket extends StatelessWidget {
  const Basket({super.key});
  static const String routeName = '/basket';

  static Route route() {
    return MaterialPageRoute(
        builder: ((_) => Basket()), settings: RouteSettings(name: routeName));
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
          title: Text('Basket',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: Colors.white)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/edit-basket');
                },
                icon: Icon(Icons.edit))
          ],
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
                child: Text('Go to Checkout'))
          ],
        )),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cutlery',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 10, bottom: 10),
                padding: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Do you need cutlery',
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                    BlocBuilder<BasketBloc, BasketState>(
                      builder: (context, state) {
                        if (state is BasketLoading) {
                          return CircularProgressIndicator();
                        } else if (state is BasketLoaded) {
                          return SizedBox(
                              width: 100,
                              child: SwitchListTile(
                                value: state.basket.cutlery,
                                dense: false,
                                activeColor:
                                    Theme.of(context).colorScheme.primary,
                                onChanged: (bool? value) {
                                  context
                                      .read<BasketBloc>()
                                      .add(ToggleSwitch());
                                },
                              ));
                        } else {
                          return Text('Something went wrong');
                        }
                      },
                    ),
                  ],
                ),
              ),
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
                                    Text(
                                        '\$${state.basket.itemQuantity(state.basket.menuItems).keys.elementAt(index).price}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge)
                                  ],
                                ),
                              );
                            }));
                  } else {
                    return Text('Something went wrong');
                  }
                },
              ),
              Container(
                width: double.infinity,
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 30),
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset('assets/delivery_time.svg'),
                    BlocBuilder<BasketBloc, BasketState>(
                      builder: (context, state) {
                        if (state is BasketLoaded) {
                          return (state.basket.deliveryTime == null)
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text('Delivery in 20 minutes',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge),
                                    TextButton(
                                      child: Text(
                                        'Change',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/deliverytime');
                                      },
                                    )
                                  ],
                                )
                              : Text(
                                  'Delivery is at ${state.basket.deliveryTime!.value}',
                                  style:
                                      Theme.of(context).textTheme.titleLarge);
                        } else {
                          return Text('Something went wrong');
                        }
                      },
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 30),
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<BasketBloc, BasketState>(
                        builder: (context, state) {
                      if (state is BasketLoading) {
                        return CircularProgressIndicator();
                      } else if (state is BasketLoaded) {
                        return (state.basket.voucher != null)
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('The voucher has been applied',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge)
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text('Do you have a voucher',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                                  TextButton(
                                    child: Text(
                                      'Apply',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/voucher');
                                    },
                                  )
                                ],
                              );
                      } else {
                        return Text('Something went wrong');
                      }
                    }),
                    SvgPicture.asset('assets/delivery_time.svg'),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 30),
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)),
                child: BlocBuilder<BasketBloc, BasketState>(
                  builder: (context, state) {
                    if (state is BasketLoading) {
                      return CircularProgressIndicator();
                    } else if (state is BasketLoaded) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('SubTotal',
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              Text('\$${state.basket.subtotalString}',
                                  style: Theme.of(context).textTheme.titleLarge)
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Delivery Fee',
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              Text('\$5.00',
                                  style: Theme.of(context).textTheme.titleLarge)
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary)),
                              Text('\$${state.basket.totalString}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary))
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Text('Something went wrong');
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
