import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../repository/forecast_result_provider.dart';
import '../repository/latlong_provider.dart';

class FelderMap extends StatelessWidget {
  final MapController mapController;
  const FelderMap({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: const LatLng(47.45, 9.29),
        initialZoom: 13.0,
        onTap: (tapPosition, latLng) {
          Provider.of<LatLongProvider>(context, listen: false).setCoordinates(latLng);
          Provider.of<ForecastResultProvider>(context,
              listen: false)
              .setForecastResults([]);
        },
        interactionOptions: const InteractionOptions(
            flags: InteractiveFlag.all & ~InteractiveFlag.rotate),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.starthack',
          tileProvider: CancellableNetworkTileProvider(),
        ),
      ],
    );
  }
}
