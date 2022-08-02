import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tembakul_mobile/features/news_slides/providers/news_provider.dart';
import 'package:tembakul_mobile/features/news_slides/widgets/slides_item_widget.dart';
import 'package:tembakul_mobile/utils/config.dart';
import 'package:tembakul_mobile/widgets/error_widget.dart';
import 'package:tembakul_mobile/widgets/shimmer_widget.dart';

class SlidesWidget extends StatefulWidget {
  const SlidesWidget({Key? key}) : super(key: key);

  @override
  State<SlidesWidget> createState() => _SlidesWidgetState();
}

class _SlidesWidgetState extends State<SlidesWidget> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<NewsProvider>().initial());
  }

  @override
  Widget build(BuildContext context) {
    final newsWatch = context.watch<NewsProvider>();
    switch (newsWatch.newsState) {
      case NewsState.Error:
        return const NotFoundWidget();
      case NewsState.Loading:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Config().padding),
          child: Loading().shimmerCustom(
              height: 200, width: MediaQuery.of(context).size.width),
        );
      case NewsState.Loaded:
        if (newsWatch.dataNews.data!.isEmpty) {
          return const NotFoundWidget(
            msg: "Banner Tidak Tersedia!",
          );
        } else {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            height: 200.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                SizedBox(width: Config().padding),
                Row(
                  children: newsWatch.dataNews.data!.map((e) {
                    return Row(
                      children: [
                        e.slides == 1
                            ? SlidesItemWidget(url: e.img!)
                            : Container(),
                        SizedBox(
                          width: Config().padding,
                        )
                      ],
                    );
                  }).toList(),
                )
              ],
            ),
          );
        }
      default:
        return Container();
    }
  }
}
