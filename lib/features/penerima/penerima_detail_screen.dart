import 'package:flutter/material.dart';
import 'package:tembakul_mobile/features/penerima/providers/penerima_detail_provider.dart';
import 'package:tembakul_mobile/widgets/header_widget.dart';
import 'package:provider/provider.dart';

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
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context
        .read<PenerimaDetailProvider>()
        .initial(idPenerima: widget.idPenerima));
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
        ]),
      )),
    );
  }
}
