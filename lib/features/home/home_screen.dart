import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tembakul_mobile/features/home/providers/home_provider.dart';
import 'package:tembakul_mobile/features/home/widgets/banner_header_widget.dart';
import 'package:tembakul_mobile/features/home/widgets/menu_widget.dart';
import 'package:tembakul_mobile/widgets/title_section_widget.dart';
import 'package:tembakul_mobile/features/news_slides/news_widget.dart';
import 'package:tembakul_mobile/features/news_slides/providers/news_provider.dart';
import 'package:tembakul_mobile/features/news_slides/slides_widget.dart';
import 'package:tembakul_mobile/utils/config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NewsProvider>().initial();
      context.read<HomeProvider>().initial();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: RefreshIndicator(
            onRefresh: () async {
              context.read<NewsProvider>().initial();
              context.read<HomeProvider>().initial();
            },
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                //header banner
                const BannerHeaderWidget(),

                //menu
                SizedBox(height: Config().padding),
                Padding(
                  padding: EdgeInsets.only(left: Config().padding),
                  child: const TitleSectionWidget(
                    title: 'Menu',
                    icon: Icons.api_sharp,
                  ),
                ),
                const MenuWidget(),

                //banner
                const SlidesWidget(),

                //news
                SizedBox(height: Config().padding),
                Padding(
                  padding: EdgeInsets.only(left: Config().padding),
                  child: const TitleSectionWidget(
                      title: "Berita", icon: Icons.newspaper),
                ),

                const NewsWidget()
              ],
            )),
      ),
    );
  }
}
