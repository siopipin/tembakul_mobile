import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tembakul_mobile/features/penerima/providers/penerima_provider.dart';
import 'package:tembakul_mobile/features/penerima/widgets/penerima_item_widget.dart';
import 'package:tembakul_mobile/utils/config.dart';
import 'package:tembakul_mobile/widgets/error_widget.dart';
import 'package:tembakul_mobile/widgets/header_widget.dart';
import 'package:tembakul_mobile/widgets/shimmer_widget.dart';

class PenerimaScreen extends StatefulWidget {
  const PenerimaScreen({Key? key}) : super(key: key);

  @override
  State<PenerimaScreen> createState() => _PenerimaScreenState();
}

class _PenerimaScreenState extends State<PenerimaScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<PenerimaProvider>().initial());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Penerima"),
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
              title: 'DATA POKTAN',
              desc: 'List data POKTAN',
              icon: Icons.list_alt_outlined),

          //body
          SizedBox(height: Config().padding),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Config().padding),
            child: listPenerima(context),
          )
        ]),
      )),
    );
  }

  listPenerima(BuildContext context) {
    final watchPenerima = context.watch<PenerimaProvider>();

    switch (watchPenerima.statePenerima) {
      case StatePenerima.error:
        return const NotFoundWidget();
      case StatePenerima.loading:
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
      case StatePenerima.loaded:
        if (watchPenerima.penerimaData.data!.isEmpty) {
          return const NotFoundWidget(
            msg: "List Penerima Tidak Tersedia!",
          );
        } else {
          return const PenerimaItemWidget();
        }
      default:
        return Container();
    }
  }
}
