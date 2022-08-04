import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tembakul_mobile/features/unggulan/providers/unggulan_provider.dart';
import 'package:tembakul_mobile/features/unggulan/widgets/unggulan_item_widget.dart';
import 'package:tembakul_mobile/utils/config.dart';
import 'package:tembakul_mobile/widgets/error_widget.dart';
import 'package:tembakul_mobile/widgets/header_widget.dart';
import 'package:tembakul_mobile/widgets/shimmer_widget.dart';

class UnggulanScreen extends StatefulWidget {
  const UnggulanScreen({Key? key}) : super(key: key);

  @override
  State<UnggulanScreen> createState() => _UnggulanScreenState();
}

class _UnggulanScreenState extends State<UnggulanScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<UnggulanProvider>().initial());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Program Unggulan"),
        elevation: 0,
      ),
      body: Scrollbar(
          child: RefreshIndicator(
        onRefresh: () async {
          await context.read<UnggulanProvider>().initial();
        },
        child: ListView(padding: EdgeInsets.zero, children: [
          //header
          const HeaderCustomeWidget(
              title: 'Program Unggulan',
              desc: 'List Program Unggulan',
              icon: Icons.privacy_tip_rounded),

          //body
          SizedBox(height: Config().padding),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Config().padding),
            child: listUnggulan(context),
          )
        ]),
      )),
    );
  }

  listUnggulan(BuildContext context) {
    final watchUnggulan = context.watch<UnggulanProvider>();

    switch (watchUnggulan.stateUnggulan) {
      case StateUnggulan.error:
        return const NotFoundWidget();
      case StateUnggulan.loading:
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
      case StateUnggulan.loaded:
        if (watchUnggulan.dataUnggulan.data!.isEmpty) {
          return const NotFoundWidget(
            msg: "List Program Unggulan Tidak Tersedia!",
          );
        } else {
          return const UnggulanItemWidget();
        }
      default:
        return Container();
    }
  }
}
