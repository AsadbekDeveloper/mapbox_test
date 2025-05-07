import 'package:mapbox_test/features/map/data/models/location_data.dart';

class LocationRepository {
  Future<List<LocationPoint>> getLocations() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return LocationDataSource.getLocations();
  }

  Future<LocationPoint?> getLocationById(String id) async {
    final locations = await getLocations();
    try {
      return locations.firstWhere((location) => location.id == id);
    } catch (_) {
      return null;
    }
  }
}
