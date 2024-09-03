import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_service/bloc/basket/basket_bloc.dart';
import 'package:food_delivery_service/models/basket_model.dart';
import 'package:food_delivery_service/models/delivery_time_model.dart';

class DeliveryTimeScreen extends StatelessWidget {
  const DeliveryTimeScreen({super.key});
  static const String routeName = '/deliverytime';

  static Route route() {
    return MaterialPageRoute(
        builder: ((_) => DeliveryTimeScreen()),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Delivery Time')),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder()),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Select'))
            ]),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Choose a Date',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Theme.of(context).colorScheme.primary)),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Delivery is Today'),
                            duration: Duration(seconds: 2),
                          ));
                        },
                        child: Text('Today')),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Delivery is Tomorrow'),
                            duration: Duration(seconds: 2),
                          ));
                        },
                        child: Text('Tomorrow')),
                  ],
                ),
              ),
              Text('Choose the Time',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Theme.of(context).colorScheme.primary)),
              Expanded(
                child: Container(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, childAspectRatio: 2.5),
                      itemCount: DeliveryTime.deliveryTimes.length,
                      itemBuilder: ((context, index) {
                        return BlocBuilder<BasketBloc, BasketState>(
                            builder: (context, state) {
                          if (state is BasketLoading) {
                            return CircularProgressIndicator();
                          } else if (state is BasketLoaded) {
                            return Card(
                                child: TextButton(
                              onPressed: () {
                                context.read<BasketBloc>().add(AddDeliveryTime(
                                    DeliveryTime.deliveryTimes[index]));
                                Navigator.pop(context);
                              },
                              child: Text(
                                '${DeliveryTime.deliveryTimes[index].value}',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              //style: Theme.of(context).textTheme.headlineLarge,),
                            ));
                          } else {
                            return Text('Something went wrong');
                          }
                          //   );
                        });
                      })),
                ),
              )
            ],
          ),
        ));
  }
}
