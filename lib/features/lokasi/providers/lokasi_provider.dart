import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tembakul_mobile/features/penerima/models/penerima_model.dart';
import 'package:tembakul_mobile/utils/api_base_helper.dart';
import 'package:tembakul_mobile/utils/app_exceptions.dart';
import 'package:tembakul_mobile/utils/global_provider.dart';

enum StatePenerimaLokasi { inital, loading, loaded, nulldata, error }

class LokasiProvider extends ChangeNotifier {
  initial() async {
    markerList.clear();
    setCurrentMapType = MapType.normal;
    await fetchPenerimaList();
    await fillMarkers();
    setMarkers = markerList;
  }

  double _centerLat = -0.1307437;
  double get centerLat => _centerLat;
  set setCenterLat(val) {
    _centerLat = val;
    notifyListeners();
  }

  double _centerLong = 109.4100328;
  double get centerLong => _centerLong;
  set setCenterLatLong(val) {
    _centerLong = val;
    notifyListeners();
  }

  //Map settings
  Completer<GoogleMapController> ctrl = Completer();
  GoogleMapController? mapController;

  List<Marker> markerList = [];

  final Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;
  set setMarkers(val) {
    _markers.addAll(val);
    notifyListeners();
  }

  fillMarkers() {
    if (statePenerima == StatePenerimaLokasi.loaded) {
      if (dataPenerima.data!.isNotEmpty) {
        for (var e in dataPenerima.data!) {
          if (e.status == 1) {
            print(e.asalKelompokTani);
            markerList.add(Marker(
              markerId: MarkerId(e.id.toString()),
              position: LatLng(double.parse(e.lat), double.parse(e.latLong)),
              infoWindow:
                  InfoWindow(title: e.asalKelompokTani, snippet: e.address),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
            ));
          }
        }
      }
    }
  }

  MapType _currentMapType = MapType.normal;
  MapType get currenMapType => _currentMapType;
  set setCurrentMapType(val) {
    _currentMapType = val;
    notifyListeners();
  }

  void onMapTypeButtonPressed() {
    _currentMapType =
        _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    notifyListeners();
  }

  onMapCreated(GoogleMapController controller) {
    if (!ctrl.isCompleted) {
      //first calling is false
      //call "completer()"
      mapController = controller;
    } else {
      //other calling, later is true,
      //don't call again completer()
    }
  }

  movePosition() {
    mapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(centerLat, centerLong), zoom: 14)));
  }

  //get data lokasi
  PenerimaModel _penerimaModel = PenerimaModel();
  PenerimaModel get dataPenerima => _penerimaModel;
  set setPenerimaModel(val) {
    _penerimaModel = val;
    notifyListeners();
  }

  StatePenerimaLokasi _statePenerima = StatePenerimaLokasi.inital;
  StatePenerimaLokasi get statePenerima => _statePenerima;
  set setStatePenerima(val) {
    _statePenerima = val;
    notifyListeners();
  }

  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<void> fetchPenerimaList() async {
    setStatePenerima = StatePenerimaLokasi.loading;
    var token = await GlobalProvider().getToken();
    final response =
        await _helper.get(url: 'hibah', needToken: true, token: token);
    switch (response[0]) {
      case null:
        setStatePenerima = StatePenerimaLokasi.error;
        Fluttertoast.showToast(msg: "Error During Communication");
        throw BadRequestException('Error During Communication');
      case 200:
        setStatePenerima = StatePenerimaLokasi.loaded;
        setPenerimaModel = PenerimaModel.fromJson(json.decode(response[1]));
        break;
      case 401:
        setStatePenerima = StatePenerimaLokasi.error;
        Fluttertoast.showToast(msg: "Unauthorised");
        throw UnauthorisedException('Unauthorised');
      default:
        setStatePenerima = StatePenerimaLokasi.error;
        Fluttertoast.showToast(msg: "Invalid Request");
        throw BadRequestException('Invalid Request');
    }
  }
}
