import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_test/features/map/data/models/location_data.dart';
import '../bloc/location_bloc.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMap? _mapboxMap;
  bool _sourcesAndLayersAdded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapbox Clustering UI')),
      body: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) {
          if (state is LocationLoaded) {
            debugPrint(
              'LocationLoaded state received with ${state.locations.length} locations',
            );

            if (_mapboxMap != null) {
              _addClusteredPoints(state.locations);
            } else {
              debugPrint('Error: _mapboxMap is null, cannot add points yet');
            }
          }
        },
        builder: (context, state) {
          if (state is LocationLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return MapWidget(
            key: const ValueKey("mapWidget"),
            cameraOptions: CameraOptions(
              center: Point(coordinates: Position(69.2401, 41.2995)),
              zoom: 5.0,
            ),
            onStyleLoadedListener: (style) {
              debugPrint('Style loaded successfully: ${style}');
            },
            onMapCreated: (mapboxMap) {
              debugPrint('Map created successfully');
              _mapboxMap = mapboxMap;

              if (context.read<LocationBloc>().state is LocationLoaded) {
                final locations =
                    (context.read<LocationBloc>().state as LocationLoaded)
                        .locations;
                debugPrint(
                  'Found ${locations.length} locations in bloc, adding to new map',
                );
                _addClusteredPoints(locations);
              }
            },
          );
        },
      ),
    );
  }

  Future<void> _addClusteredPoints(List<LocationPoint> locations) async {
    debugPrint('Adding clustered points: ${locations.length}');

    if (_mapboxMap == null) {
      debugPrint('Error: _mapboxMap is null');
      return;
    }

    try {
      final features =
          locations.map((location) {
            return {
              "type": "Feature",
              "geometry": {
                "type": "Point",
                "coordinates": [location.longitude, location.latitude],
              },
              "properties": {
                "id": location.id,
                "name": location.name,
                "description": location.description,
              },
            };
          }).toList();

      final geoJson = {"type": "FeatureCollection", "features": features};

      debugPrint('GeoJSON has ${features.length} features');

      if (_sourcesAndLayersAdded) {
        await _mapboxMap?.style.removeStyleLayer('cluster-count');
        await _mapboxMap?.style.removeStyleLayer('clusters');
        await _mapboxMap?.style.removeStyleLayer('unclustered-point');
        await _mapboxMap?.style.removeStyleSource('clusters');
      }

      await _mapboxMap?.style.addSource(
        GeoJsonSource(
          id: 'clusters',
          data: jsonEncode(geoJson),
          cluster: true,
          clusterRadius: 50,
          clusterMaxZoom: 14,
        ),
      );

      await _mapboxMap?.style.addLayer(
        CircleLayer(
          id: 'clusters',
          sourceId: 'clusters',
          filter: ['has', 'point_count'],
          circleColor: Colors.lightBlue.value,
          circleRadius: 15.0,
        ),
      );

      await _mapboxMap?.style.addLayer(
        SymbolLayer(
          id: 'cluster-count',
          sourceId: 'clusters',
          filter: ['has', 'point_count'],
          textField: '{point_count_abbreviated}',
          textFont: ['DIN Offc Pro Medium', 'Arial Unicode MS Bold'],
          textSize: 12.0,
        ),
      );

      await _mapboxMap?.style.addLayer(
        CircleLayer(
          id: 'unclustered-point',
          sourceId: 'clusters',
          filter: [
            '!',
            ['has', 'point_count'],
          ],
          circleColor: Colors.blue.value,
          circleRadius: 8.0,
          circleStrokeWidth: 2.0,
          circleStrokeColor: Colors.white.value,
        ),
      );
      debugPrint('GeoJSON: ${jsonEncode(geoJson)}');
      _sourcesAndLayersAdded = true;
      debugPrint('Clustered points added successfully');
    } catch (e) {
      debugPrint('Error in _addClusteredPoints: $e');
    }
  }

  Future<void> _onMapClick(Point point, screenPoint) async {
    final clusterFeatures = await _mapboxMap?.queryRenderedFeatures(
      screenPoint,
      RenderedQueryOptions(layerIds: ['clusters']),
    );

    if (clusterFeatures != null && clusterFeatures.isNotEmpty) {
      final cluster = clusterFeatures.first;
      final clusterId = cluster?.queriedFeature.feature.entries.firstWhere(
        (entry) => entry.key == 'cluster_id',
      );

      if (clusterId != null) {
        final zoom = await _mapboxMap?.getGeoJsonClusterExpansionZoom(
          'locations',
          clusterId as Map<String?, Object?>,
        );

        return;
      }
    }

    final singleFeatures = await _mapboxMap?.queryRenderedFeatures(
      screenPoint,
      RenderedQueryOptions(layerIds: ['unclustered-point']),
    );

    if (singleFeatures != null && singleFeatures.isNotEmpty) {
      final properties = singleFeatures.first?.queriedFeature.feature;
      final name = properties?['name'] ?? 'No name';
      final desc = properties?['description'] ?? 'No description';

      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text(name.toString()),
              content: Text(desc.toString()),
            ),
      );
    }
  }
}
