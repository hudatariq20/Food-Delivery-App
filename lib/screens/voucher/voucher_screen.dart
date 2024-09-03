import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_service/bloc/voucher/vouchers_bloc.dart';


class VoucherScreen extends StatelessWidget {
  const VoucherScreen({super.key});
  static const String routeName = '/voucher';

  static Route route() {
    return MaterialPageRoute(
        builder: ((_) => VoucherScreen()),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Voucher')),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder()),
                    onPressed: () {},
                    child: Text(
                      'Apply',
                    ))
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter a Voucher Code',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Voucher Code',
                            contentPadding: EdgeInsets.all(10)),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                'Your Vouchers',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              BlocBuilder<VouchersBloc, VouchersState>(
                builder: (context, state) {
                  if (state is VoucherLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is VoucherLoaded) {
                    return ListView.builder(
                        itemCount: state.vouchers.length,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          return Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('1x',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary)),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Text(state.vouchers[index].code,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge)),
                              
                                  TextButton(
                                      child: Text(
                                        'Apply',
                                      ),
                                      onPressed: () {
                                        context.read<VouchersBloc>().add(
                                            SelectVoucher(
                                              voucher:  state.vouchers[index]));
                                        Navigator.pop(context);
                                      },
                                    )
                                  
                                
                              ],
                            ),
                          );
                        }));
                  } else {
                    return Text('Something went wrong');
                  }
                },
              )
            ],
          ),
        ));
  }
}
