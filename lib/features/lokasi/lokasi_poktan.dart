import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tembakul_mobile/widgets/header_widget.dart';
import 'package:tembakul_mobile/widgets/header_widget_with_search.dart';

const maxMarkersCount = 1000;

/// On this page, [maxMarkersCount] markers are randomly generated
/// across europe, and then you can limit them with a slider
///
/// This way, you can test how map performs under a lot of markers
class LokasiPokTan extends StatefulWidget {
  static const String route = '/many_markers';

  const LokasiPokTan({Key? key}) : super(key: key);

  @override
  _ManyMarkersPageState createState() => _ManyMarkersPageState();
}

class _ManyMarkersPageState extends State<LokasiPokTan> {
  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;
  List<Marker> allMarkers = [];

  int _sliderVal = maxMarkersCount ~/ 10;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final r = Random();
      for (var x = 0; x < maxMarkersCount; x++) {
        allMarkers.add(
          Marker(
            point: LatLng(
              doubleInRange(r, 37, 55),
              doubleInRange(r, -9, 30),
            ),
            builder: (context) => const Icon(
              Icons.circle,
              color: Colors.red,
              size: 12,
            ),
          ),
        );
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lokasi PokTan"),
        elevation: 0,
      ),
      body: Column(
        children: [
          HeaderWithSearchWidget(
            title: 'Lokasi PokTan',
            desc: 'Cari nama PokTan',
            icon: Icons.location_on_outlined,
          ),
          Flexible(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(3.595196, 98.672226),
                zoom: 15,
                interactiveFlags: InteractiveFlag.all - InteractiveFlag.rotate,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                    markers: allMarkers.sublist(
                        0, min(allMarkers.length, _sliderVal))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}