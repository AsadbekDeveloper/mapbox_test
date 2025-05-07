import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mapbox_test/core/config/env.dart';
import 'package:mapbox_test/features/map/domain/repositories/location_repository.dart';
import 'package:mapbox_test/features/map/presentation/bloc/location_bloc.dart';
import 'package:mapbox_test/features/map/presentation/screens/map_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load();
  MapboxOptions.setAccessToken(Env.mapboxAccessToken);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final LocationRepository locationRepository = LocationRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => LocationBloc(locationRepository)..add(LoadLocations()),
        child: const MapScreen(),
      ),
    );
  }
}