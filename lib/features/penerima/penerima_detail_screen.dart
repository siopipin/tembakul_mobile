import 'package:flutter/material.dart';
import 'package:tembakul_mobile/features/penerima/providers/penerima_detail_provider.dart';
import 'package:tembakul_mobile/widgets/header_widget.dart';
import 'package:provider/provider.dart';

//map import
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
// import 'package:latlong/latlong.dart';

class PenerimaDetailScreen extends StatefulWidget {
  final String idPenerima;
  final String namaKetua;
  final String asalPokTan;
  const PenerimaDetailScreen(
      {Key? key,
      required this.idPenerima,
      required this.namaKetua,
      required this.asalPokTan})
      : super(key: key);

  @override
  State<PenerimaDetailScreen> createState() => _PenerimaDetailScreenState();
}

class _PenerimaDetailScreenState extends State<PenerimaDetailScreen> {
  final PopupController _popupController = PopupController();
  MapController mapController = MapController();
  double zoom = 7;
  // List<LatLng> latLngList = [
  //   LatLng(13, 77.5),
  //   LatLng(13.02, 77.51),
  //   LatLng(13.05, 77.53),
  //   LatLng(13.055, 77.54),
  //   LatLng(13.059, 77.55),
  //   LatLng(13.07, 77.55),
  //   LatLng(13.1, 77.5342),
  //   LatLng(13.12, 77.51),
  //   LatLng(13.015, 77.53),
  //   LatLng(13.155, 77.54),
  //   LatLng(13.159, 77.55),
  //   LatLng(13.17, 77.55),
  // ];
  List<Marker> _markers = [];
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context
        .read<PenerimaDetailProvider>()
        .initial(idPenerima: widget.idPenerima));

    //Marker
    // _markers = latLngList
    //     .map((point) => Marker(
    //           point: point,
    //           width: 60,
    //           height: 60,
    //           builder: (context) => Icon(
    //             Icons.pin_drop,
    //             size: 60,
    //             color: Colors.blueAccent,
    //           ),
    //         ))
    //     .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Penerima'),
        elevation: 0,
      ),
      body: Scrollbar(
          child: RefreshIndicator(
        onRefresh: () async {},
        child: ListView(children: [
          //header
          HeaderCustomeWidget(
              title: widget.asalPokTan,
              desc: "Ketua Pengusul: ${widget.namaKetua}",
              icon: Icons.list_alt_outlined),

          //body
          Flexible(
              child: FlutterMap(
            mapController: mapController,
            options: MapOptions(
              // swPanBoundary: LatLng(13, 77.5),
              // nePanBoundary: LatLng(13.07001, 77.58),
              // center: latLngList[0],
              // bounds: LatLngBounds.fromPoints(latLngList),
              zoom: zoom,
              plugins: [
                MarkerClusterPlugin(),
              ],
              // onTap: (_) => _popupController.hidePopup(),
            ),
            layers: [
              TileLayerOptions(
                minZoom: 2,
                maxZoom: 18,
                backgroundColor: Colors.black,
                // errorImage: ,
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerClusterLayerOptions(
                maxClusterRadius: 190,
                disableClusteringAtZoom: 16,
                size: Size(50, 50),
                fitBoundsOptions: FitBoundsOptions(
                  padding: EdgeInsets.all(50),
                ),
                markers: _markers,
                polygonOptions: PolygonOptions(
                    borderColor: Colors.blueAccent,
                    color: Colors.black12,
                    borderStrokeWidth: 3),
                popupOptions: PopupOptions(
                    popupSnap: PopupSnap.mapTop,
                    popupController: _popupController,
                    popupBuilder: (_, marker) => Container(
                          color: Colors.amberAccent,
                          child: Text('Popup'),
                        )),
                builder: (context, markers) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.orange, shape: BoxShape.circle),
                    child: Text('${markers.length}'),
                  );
                },
              ),
            ],
          ))
        ]),
      )),
    );
  }
}
