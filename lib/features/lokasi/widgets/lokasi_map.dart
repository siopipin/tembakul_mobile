import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tembakul_mobile/features/lokasi/providers/lokasi_provider.dart';

class LokasiMap extends StatelessWidget {
  const LokasiMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watchLokasi = context.watch<LokasiProvider>();

    return Flexible(
        child: Stack(
      children: <Widget>[
        GoogleMap(
          onMapCreated: watchLokasi.onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(watchLokasi.centerLat, watchLokasi.centerLong),
            zoom: 15,
          ),
          mapType: watchLokasi.currenMapType,
          markers: watchLokasi.markers,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: watchLokasi.onMapTypeButtonPressed,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  child: const Icon(Icons.map, size: 36.0),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
