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
    final watchNew = context.watch<NewsProvider>();
    switch (watchNew.newsState) {
      case NewsState.Error:
        return const NotFoundWidget();
      case NewsState.Loading:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Config().padding),
          child: Loading().shimmerCustom(
              height: 200, width: MediaQuery.of(context).size.width),
        );
      case NewsState.Loaded:
        if (watchNew.dataNews.data!.isEmpty) {
          return const NotFoundWidget(
            msg: "Banner Tidak Tersedia!",
          );
        } else {
          return SizedBox(
            height: 200.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Row(
                  children: watchNew.dataNews.data!.map((e) {
                    return Row(
                      children: [
                        e.slides == 1
                            ? Padding(
                                padding:
                                    EdgeInsets.only(left: Config().padding / 2),
                                child: SlidesItemWidget(url: e.img!),
                              )
                            : Container(),
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
