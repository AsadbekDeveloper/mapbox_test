class LocationPoint {
  final String id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;

  const LocationPoint({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() {
    return 'LocationPoint{id: $id, name: $name, latitude: $latitude, longitude: $longitude}';
  }
}

class LocationDataSource {
  static List<LocationPoint> getLocations() {
    return [
      const LocationPoint(
        id: 'loc_001',
        name: 'Tashkent',
        description: 'Capital of Uzbekistan',
        latitude: 41.2995,
        longitude: 69.2401,
      ),
      const LocationPoint(
        id: 'loc_002',
        name: 'Samarkand',
        description: 'Historical city in Uzbekistan',
        latitude: 39.6542,
        longitude: 66.9597,
      ),
      const LocationPoint(
        id: 'loc_003',
        name: 'Bukhara',
        description: 'Ancient city in Uzbekistan',
        latitude: 39.7748,
        longitude: 64.4295,
      ),
      const LocationPoint(
        id: 'loc_004',
        name: 'Fergana',
        description: 'City in Uzbekistan',
        latitude: 40.3847,
        longitude: 71.7912,
      ),
      const LocationPoint(
        id: 'loc_005',
        name: 'Khiva',
        description: 'Historical city in Uzbekistan',
        latitude: 41.3776,
        longitude: 60.3751,
      ),
      const LocationPoint(
        id: 'loc_006',
        name: 'Andijan',
        description: 'City in Uzbekistan, near Kyrgyzstan border',
        latitude: 40.7794,
        longitude: 72.3426,
      ),
      const LocationPoint(
        id: 'loc_007',
        name: 'Namangan',
        description: 'City in Uzbekistan',
        latitude: 40.1000,
        longitude: 71.6700,
      ),
      const LocationPoint(
        id: 'loc_008',
        name: 'Nukus',
        description: 'Capital of the autonomous Republic of Karakalpakstan',
        latitude: 42.4560,
        longitude: 59.6234,
      ),
      const LocationPoint(
        id: 'loc_009',
        name: 'Shahrisabz',
        description: 'Historical city in Uzbekistan',
        latitude: 39.2154,
        longitude: 66.8233,
      ),
      const LocationPoint(
        id: 'loc_010',
        name: 'Termez',
        description: 'City in southern Uzbekistan, near Afghanistan',
        latitude: 37.2200,
        longitude: 67.2890,
      ),
      const LocationPoint(
        id: 'loc_011',
        name: 'Zarafshan',
        description: 'City in Uzbekistan known for gold mining',
        latitude: 39.1846,
        longitude: 64.4243,
      ),
      const LocationPoint(
        id: 'loc_012',
        name: 'Bekabad',
        description: 'City in Tashkent region',
        latitude: 40.2520,
        longitude: 68.8674,
      ),
      const LocationPoint(
        id: 'loc_013',
        name: 'Kokand',
        description: 'Historical city in Fergana Valley',
        latitude: 40.5376,
        longitude: 70.9499,
      ),
      const LocationPoint(
        id: 'loc_014',
        name: 'Jizzakh',
        description: 'City in Uzbekistan',
        latitude: 40.1077,
        longitude: 67.7412,
      ),
      const LocationPoint(
        id: 'loc_015',
        name: 'Margilan',
        description: 'City in Fergana Valley known for silk production',
        latitude: 40.4563,
        longitude: 71.7341,
      ),
      const LocationPoint(
        id: 'loc_016',
        name: 'Urgench',
        description: 'City near Khiva in Uzbekistan',
        latitude: 41.5547,
        longitude: 60.6099,
      ),
      const LocationPoint(
        id: 'loc_017',
        name: 'Gulistan',
        description: 'City in Syrdarya Province',
        latitude: 40.5094,
        longitude: 68.2537,
      ),
      const LocationPoint(
        id: 'loc_018',
        name: 'Karshi',
        description: 'City in southern Uzbekistan',
        latitude: 38.8564,
        longitude: 65.8257,
      ),
      const LocationPoint(
        id: 'loc_019',
        name: 'Kashkadarya',
        description: 'Region in southern Uzbekistan',
        latitude: 38.2000,
        longitude: 65.5000,
      ),
      const LocationPoint(
        id: 'loc_020',
        name: 'Chirchik',
        description: 'City in Tashkent Region',
        latitude: 41.6064,
        longitude: 69.6162,
      ),
    ];
  }
}
