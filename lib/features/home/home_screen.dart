import 'package:flutter/material.dart';
import 'package:tembakul_mobile/features/home/widgets/banner_header_widget.dart';
import 'package:tembakul_mobile/features/home/widgets/menu_widget.dart';
import 'package:tembakul_mobile/features/home/widgets/title_section_widget.dart';
import 'package:tembakul_mobile/features/news_slides/slides_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            //header banner
            BannerHeaderWidget(),

            //menu
            TitleSectionWidget(
              title: 'Menu',
              icon: Icons.api_sharp,
            ),
            MenuWidget(),

            //banner
            SlidesWidget(),

            //news
            TitleSectionWidget(title: "Berita", icon: Icons.newspaper),
          ],
        ),
      ),
    );
  }
}
