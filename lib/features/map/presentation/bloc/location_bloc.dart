import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_test/features/map/data/models/location_data.dart';
import 'package:mapbox_test/features/map/domain/repositories/location_repository.dart';
part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository repository;

  LocationBloc(this.repository) : super(LocationInitial()) {
    on<LoadLocations>((event, emit) async {
      emit(LocationLoading());
      try {
        final locations = await repository.getLocations();
        emit(LocationLoaded(locations));
      } catch (e) {
        emit(LocationError('Failed to load locations'));
      }
    });
  }
}