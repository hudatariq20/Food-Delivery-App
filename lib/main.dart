import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_service/bloc/autocomplete/autocomplete_bloc.dart';
import 'package:food_delivery_service/bloc/basket/basket_bloc.dart';
import 'package:food_delivery_service/bloc/blocs.dart';
import 'package:food_delivery_service/bloc/filter/filter_bloc.dart';
import 'package:food_delivery_service/bloc/voucher/vouchers_bloc.dart';
import 'package:food_delivery_service/config/app_router.dart';
import 'package:food_delivery_service/config/theme.dart';
import 'package:food_delivery_service/respositories/geolocation/geolocation_repository.dart';
import 'package:food_delivery_service/respositories/places/places_repository.dart';
import 'package:food_delivery_service/respositories/voucher/voucher_repository.dart';
import 'package:food_delivery_service/screens/onboarding/onboarding_screen.dart';
import 'package:food_delivery_service/screens/profile/profile_screen.dart';
import 'package:food_delivery_service/simple_bloc_observer.dart';

import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  BlocOverrides.runZoned(() => runApp(const MyApp()),
      blocObserver: SimpleBlocObserver());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PlacesRepository>(
            create: ((_) => PlacesRepository())),
        RepositoryProvider<GeoLocationRepository>(
            create: ((_) => GeoLocationRepository())),
        // RepositoryProvider<VoucherRepository>
        //       (create: (_) => VoucherRepository(firebaseFirestore: firebaseFirestore))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: ((context) => AutocompleteBloc(
                  placesRepository: context.read<PlacesRepository>())
                ..add(LoadAutocomplete()))),
          BlocProvider(
              create: ((context) => LocationBloc(
                  placesRepository: context.read<PlacesRepository>(),
                  geoLocationRepository: context.read<GeoLocationRepository>())
                ..add(LoadMap()))),
          BlocProvider(create: (context) => FilterBloc()..add(LoadFilter())),
          BlocProvider(
            create: (context) =>
                VouchersBloc(voucherRepository: VoucherRepository())
                  ..add(LoadVoucher()),
          ),
          BlocProvider(
              create: ((context) => BasketBloc(
                  vouchersBloc: BlocProvider.of<VouchersBloc>(context))
                ..add(StartBasket()))),
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: theme(),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: OnboardingScreen.routeName),
      ),
    );
  }
}
