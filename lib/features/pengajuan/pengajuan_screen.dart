import 'package:flutter/material.dart';
import 'package:tembakul_mobile/features/pengajuan/providers/pengajuan_providers.dart';
import 'package:tembakul_mobile/features/pengajuan/widgets/form_pengajuan_widget.dart';
import 'package:tembakul_mobile/utils/config.dart';
import 'package:tembakul_mobile/widgets/header_widget.dart';
import 'package:tembakul_mobile/widgets/title_section_widget.dart';
import 'package:provider/provider.dart';

class PengajuanScreen extends StatefulWidget {
  const PengajuanScreen({Key? key}) : super(key: key);

  @override
  State<PengajuanScreen> createState() => _PengajuanScreenState();
}

class _PengajuanScreenState extends State<PengajuanScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PengajuanProvider>().initial();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengajuan"),
        elevation: 0,
      ),
      body: Scrollbar(
          child: RefreshIndicator(
        onRefresh: () async {},
        child: ListView(padding: EdgeInsets.zero, children: [
          //header
          HeaderWidget(
            title: 'Daftarkan Berkas POLTAK',
            desc: 'Pastikan berkas pengajuan lengkap dan dalam format .pdf',
            icon: Icons.app_registration,
          ),
          SizedBox(height: Config().padding),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Config().padding),
            child: Column(children: [
              //form
              FormPengajuanWidget()

              //action
            ]),
          )

          //action
        ]),
      )),
    );
  }
}
