import 'package:flutter/material.dart';
import 'package:tembakul_mobile/utils/config.dart';
import 'package:tembakul_mobile/widgets/header_widget.dart';

class AboutScreen extends StatefulWidget {
  AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        elevation: 0,
      ),
      body: Scrollbar(
          child: RefreshIndicator(
        onRefresh: () async {},
        child: ListView(padding: EdgeInsets.zero, children: [
          //header
          const HeaderCustomeWidget(
              title: 'Tentang Disbunnak',
              desc: 'Informasi Kontak',
              icon: Icons.info),

          Container(
            margin: EdgeInsets.all(Config().padding),
            padding: EdgeInsets.all(Config().padding),
            decoration: BoxDecoration(
                color: Config().colorItem,
                borderRadius: BorderRadius.circular(Config().padding)),
            child: Column(children: [
              itemDetail(
                icon: Icons.call,
                desc: '(0561) 72238',
              ),
              itemDetail(icon: Icons.web, desc: 'disbunnak.kuburayakab.go.id'),
              itemDetail(icon: Icons.facebook, desc: '@disbunnakkuburaya'),
              itemDetail(
                  icon: Icons.video_collection_rounded,
                  desc: 'disbunnak kuburaya'),
            ]),
          )
        ]),
      )),
    );
  }

  itemDetail({required IconData icon, required String desc}) {
    return Container(
      margin: EdgeInsets.only(bottom: Config().padding / 2),
      child: Row(
        children: [
          Padding(
              padding: EdgeInsets.only(right: Config().padding),
              child: Icon(icon, color: Config().colorPrimary)),
          Text(desc)
        ],
      ),
    );
  }
}
