import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tembakul_mobile/features/penerima/providers/penerima_provider.dart';
import 'package:tembakul_mobile/features/penerima/widgets/penerima_item_widget.dart';
import 'package:tembakul_mobile/features/perusahaan/providers/perusahaan_provider.dart';
import 'package:tembakul_mobile/features/perusahaan/widgets/perusahaan_item_widget.dart';
import 'package:tembakul_mobile/utils/config.dart';
import 'package:tembakul_mobile/widgets/error_widget.dart';
import 'package:tembakul_mobile/widgets/header_widget.dart';
import 'package:tembakul_mobile/widgets/shimmer_widget.dart';

class PerusahaanScreen extends StatefulWidget {
  const PerusahaanScreen({Key? key}) : super(key: key);

  @override
  State<PerusahaanScreen> createState() => _PerusahaanScreenState();
}

class _PerusahaanScreenState extends State<PerusahaanScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<PerusahaanProvider>().initial());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perusahaan"),
        elevation: 0,
      ),
      body: Scrollbar(
          child: RefreshIndicator(
        onRefresh: () async {
          await context.read<PenerimaProvider>().initial();
        },
        child: ListView(padding: EdgeInsets.zero, children: [
          //header
          const HeaderCustomeWidget(
              title: 'Data Perusahaan',
              desc: 'List Data Perusahaan',
              icon: Icons.home_work_outlined),

          //body
          SizedBox(height: Config().padding),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Config().padding),
            child: listPerusahaan(context),
          )
        ]),
      )),
    );
  }

  listPerusahaan(BuildContext context) {
    final watchPerusahaan = context.watch<PerusahaanProvider>();

    switch (watchPerusahaan.statePerusahaan) {
      case StatePerusahaan.error:
        return const NotFoundWidget();
      case StatePerusahaan.loading:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Config().padding),
          child: Column(
              children: List.generate(
                  3,
                  (index) => Padding(
                        padding: EdgeInsets.only(bottom: Config().padding),
                        child: Loading().shimmerCustom(
                            height: 80,
                            width: MediaQuery.of(context).size.width),
                      ))),
        );
      case StatePerusahaan.loaded:
        if (watchPerusahaan.dataPerusahaan.data!.isEmpty) {
          return const NotFoundWidget(
            msg: "List Perusahaan Tidak Tersedia!",
          );
        } else {
          return const PerusahaanItemWidget();
        }
      default:
        return Container();
    }
  }
}
