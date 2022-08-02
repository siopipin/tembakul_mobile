import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tembakul_mobile/utils/config.dart';
import 'package:tembakul_mobile/widgets/shimmer_widget.dart';

class NewsItemWidget extends StatelessWidget {
  final String url;
  final String title;
  final String date;
  final String description;
  const NewsItemWidget(
      {Key? key,
      required this.url,
      required this.title,
      required this.date,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //images news
        CachedNetworkImage(
          imageUrl: "${Config().urlNewsImg}$url",
          imageBuilder: (context, imageProvider) => Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Config().padding),
                bottomLeft: Radius.circular(Config().padding),
              ),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) =>
              Loading().shimmerCustom(height: 140, width: 140),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          height: 150,
          width: 150,
        ),

        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Config().colorItem,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Config().padding),
                bottomRight: Radius.circular(Config().padding),
              ),
            ),
            padding: EdgeInsets.all(Config().padding),
            height: 150,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                title.length > 50 ? "${title.substring(0, 49)}..." : title,
                style: TextStyle(
                    fontSize: Config().fontSizeH2, fontWeight: FontWeight.bold),
              ),
              Text(
                Config().dateFormat.format(DateTime.parse(date)),
                style: TextStyle(
                    fontSize: Config().fontSizeTiny,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: Config().padding / 2,
              ),
              Text(description.length > 80
                  ? "${description.substring(0, 79)}..."
                  : description)
            ]),
          ),
        )
      ],
    );
  }
}
