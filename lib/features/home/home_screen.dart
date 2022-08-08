import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tembakul_mobile/features/about/about_screen.dart';
import 'package:tembakul_mobile/features/home/dashboard_screen.dart';
import 'package:tembakul_mobile/features/home/providers/home_provider.dart';
import 'package:tembakul_mobile/features/home/widgets/home_header_widget.dart';
import 'package:tembakul_mobile/features/home/widgets/menu_widget.dart';
import 'package:tembakul_mobile/features/news_slides/news_all.dart';
import 'package:tembakul_mobile/features/news_slides/providers/news_top_provider.dart';
import 'package:tembakul_mobile/features/news_slides/widgets/news_top_widget.dart';
import 'package:tembakul_mobile/widgets/title_section_widget.dart';
import 'package:tembakul_mobile/features/news_slides/widgets/news_widget.dart';
import 'package:tembakul_mobile/features/news_slides/providers/news_provider.dart';
import 'package:tembakul_mobile/features/news_slides/slides_widget.dart';
import 'package:tembakul_mobile/utils/config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? index;
  List<Widget> itemHome = [const DashboardScreen(), AboutScreen()];

  @override
  void initState() {
    super.initState();
    index = 0;
    Future.microtask(() {
      context.read<NewsTopProvider>().initial();
      context.read<HomeProvider>().initial();
    });
  }

  changeIndex(val) {
    setState(() {
      index = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: itemHome[index!],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Call',
          ),
        ],
        selectedItemColor: Config().colorItem,
        unselectedItemColor: Colors.grey[200],
        backgroundColor: Config().colorPrimary,
        currentIndex: index!,
        onTap: (index) {
          changeIndex(index);
        },
      ),
    );
  }
}
