import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

class LatLongProvider extends ChangeNotifier {
  LatLng? coordinates;

  void setCoordinates(LatLng latLng) {
    coordinates = latLng;
    notifyListeners();
  }
}