import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:start_hack/features/map/repository/forecast_result_provider.dart';
import 'package:start_hack/features/map/repository/syngenta_api_repository.dart';

class FelderMap extends StatelessWidget {
  final MapController mapController;
  const FelderMap({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: const LatLng(51.8, 7.3),
        initialZoom: 13.0,
        onTap: (tapPosition, latLng) {
          Provider.of<HttpSyngentaRepository>(context, listen: false).getShortRangeForecastDaily(
              "json",
              "Meteoblue",
              "2024-03-20",
              "",
              "TempAir_DailyAvg%20(C);TempAir_DailyMax%20(C);TempAir_DailyMin%20(C);Precip_DailySum%20(mm);WindDirection_DailyAvg%20(Deg);WindSpeed_DailyAvg%20(m/s);HumidityRel_DailyAvg%20(pct);WindDirection_DailyAvg;Soilmoisture_0to10cm_DailyAvg%20(vol%25);WindGust_DailyMax%20(m/s);Referenceevapotranspiration_DailySum%20(mm);TempSurface_DailyAvg%20(C);Soiltemperature_0to10cm_DailyAvg%20(C)",
              latLng.latitude,
              latLng.longitude).then((value) {
            Provider.of<ForecastResultProvider>(context, listen: false).setForecastResults(value);
          });
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
