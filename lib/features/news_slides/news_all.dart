import 'package:flutter/material.dart';
import 'package:tembakul_mobile/features/news_slides/widgets/news_widget.dart';
import 'package:tembakul_mobile/features/news_slides/providers/news_provider.dart';
import 'package:tembakul_mobile/utils/config.dart';
import 'package:tembakul_mobile/widgets/header_widget.dart';
import 'package:provider/provider.dart';

class NewsAllScreen extends StatefulWidget {
  const NewsAllScreen({Key? key}) : super(key: key);

  @override
  State<NewsAllScreen> createState() => _NewsAllScreenState();
}

class _NewsAllScreenState extends State<NewsAllScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<NewsProvider>().initial());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Berita"),
        elevation: 0,
      ),
      body: Scrollbar(
          child: RefreshIndicator(
        onRefresh: () async => context.read<NewsProvider>().initial(),
        child: ListView(children: [
          //header
          const HeaderCustomeWidget(
              title: 'List Berita',
              desc: 'Berita terbaru',
              icon: Icons.newspaper),
          SizedBox(height: Config().padding),
          const NewsWidget()
        ]),
      )),
    );
  }
}
