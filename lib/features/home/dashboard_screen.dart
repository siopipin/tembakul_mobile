import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tembakul_mobile/features/home/providers/home_provider.dart';
import 'package:tembakul_mobile/features/home/widgets/home_header_widget.dart';
import 'package:tembakul_mobile/features/home/widgets/menu_widget.dart';
import 'package:tembakul_mobile/features/news_slides/news_all.dart';
import 'package:tembakul_mobile/features/news_slides/providers/news_top_provider.dart';
import 'package:tembakul_mobile/features/news_slides/slides_widget.dart';
import 'package:tembakul_mobile/features/news_slides/widgets/news_top_widget.dart';
import 'package:tembakul_mobile/utils/config.dart';
import 'package:tembakul_mobile/widgets/title_section_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: RefreshIndicator(
          onRefresh: () async {
            context.read<NewsTopProvider>().initial();
            context.read<HomeProvider>().initial();
          },
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              //header banner
              const HomeHeaderWidget(),

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
                padding: EdgeInsets.symmetric(horizontal: Config().padding),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const TitleSectionWidget(
                          title: "Berita", icon: Icons.newspaper),
                      TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const NewsAllScreen()))),
                          child: Text(
                            'Lihat Semua >',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Config().fontSizeH3),
                          ))
                    ]),
              ),

              const NewsTopWidget()
            ],
          )),
    );
  }
}
