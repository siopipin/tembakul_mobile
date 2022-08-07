import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tembakul_mobile/features/lokasi/providers/lokasi_provider.dart';
import 'package:tembakul_mobile/features/lokasi/widgets/lokasi_map.dart';
import 'package:tembakul_mobile/widgets/header_widget_with_search.dart';

class LokasiPoktanScreen extends StatefulWidget {
  const LokasiPoktanScreen({Key? key}) : super(key: key);

  @override
  State<LokasiPoktanScreen> createState() => _LokasiPoktanScreenState();
}

class _LokasiPoktanScreenState extends State<LokasiPoktanScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<LokasiProvider>().initial());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lokasi PokTan"),
        elevation: 0,
      ),
      body: Column(children: const [
        HeaderWithSearchWidget(
          title: 'Lokasi POKTAN',
          desc: 'Cari nama POKTAN',
          textSearch: 'Cari PokTan',
          icon: Icons.location_on_outlined,
          isAutoComplete: true,
        ),
        LokasiMap()
      ]),
    );
  }
}
