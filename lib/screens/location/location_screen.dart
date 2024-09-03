import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery_service/bloc/autocomplete/autocomplete_bloc.dart';
import 'package:food_delivery_service/bloc/location/location_bloc.dart';
import 'package:food_delivery_service/widgets/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({super.key});
  static const String routeName = '/location';

  static Route route() {
    return MaterialPageRoute(
        builder: ((_) => LocationScreen()),
        settings: RouteSettings(name: routeName));
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state is LocationLoading) {
          return CircularProgressIndicator();
        } else if (state is LocationLoaded) {
          return Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: GoogleMap(
                    myLocationButtonEnabled: true,
                    buildingsEnabled: false,
                    onMapCreated: ((GoogleMapController controller) {
                      context
                          .read<LocationBloc>()
                          .add(LoadMap(controller: controller));
                    }),
                    initialCameraPosition: CameraPosition(
                        target: LatLng(state.lat, state.lan), zoom: 15)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
                child: Column(children: [
                  Container(
                    height: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/logo.svg',
                          height: 50,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: LocationSearchBox()),
                      ],
                    ),
                  ),
                  _LocationSuggestionBox(),
                  Expanded(child: SizedBox()),
                  SaveButton()
                ]),
              ),
            ],
          );
        } else {
          return Text('Something went wrong');
        }
      },
    ));
  }
}

class _LocationSuggestionBox extends StatelessWidget {
  const _LocationSuggestionBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutocompleteBloc, AutocompleteState>(
      builder: (context, state) {
        if (state is AutocompleteLoading) {
          return SizedBox();
        }
        if (state is AutocompleteLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: state.autocomplete.length,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.black.withOpacity(0.6),
                child: ListTile(
                  title: Text(state.autocomplete[index].description!,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.white)),
                  onTap: () {
                    context.read<LocationBloc>().add(SearchLocation(
                        placeId: state.autocomplete[index].placeId!));

                    context.read<AutocompleteBloc>().add(ClearAutoComplete());
                  },
                ),
              );
            },
          );
        } else {
          return Text('Something went wrong');
        }
      },
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(fixedSize: Size(150, 30)),
        child: Text('Save'),
        onPressed: () {
          Navigator.pushNamed(context, '/');
        },
      ),
    );
  }
}
