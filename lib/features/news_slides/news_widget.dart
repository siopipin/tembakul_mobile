import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tembakul_mobile/features/news_slides/providers/news_provider.dart';
import 'package:tembakul_mobile/features/news_slides/widgets/news_item_widget.dart';
import 'package:tembakul_mobile/utils/config.dart';
import 'package:tembakul_mobile/widgets/error_widget.dart';
import 'package:tembakul_mobile/widgets/shimmer_widget.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({Key? key}) : super(key: key);

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    final watchNews = context.watch<NewsProvider>();
    switch (watchNews.newsState) {
      case NewsState.Error:
        return const NotFoundWidget();
      case NewsState.Loading:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Config().padding),
          child: Loading().shimmerCustom(
              height: 200, width: MediaQuery.of(context).size.width),
        );
      case NewsState.Loaded:
        if (watchNews.dataNews.data!.isEmpty) {
          return const NotFoundWidget(
            msg: "Berita Tidak Tersedia!",
          );
        } else {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: Config().padding),
              child: Column(
                children: watchNews.dataNews.data!.map((e) {
                  return Column(
                    children: [
                      e.slides == 0
                          ? NewsItemWidget(
                              url: e.img!,
                              title: e.title!,
                              date: e.dateCreated!,
                              description: e.description!,
                            )
                          : Container(),
                      SizedBox(
                        height: Config().padding / 2,
                      )
                    ],
                  );
                }).toList(),
              ));
        }
      default:
        return Container();
    }
  }
}
