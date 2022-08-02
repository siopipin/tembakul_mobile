import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tembakul_mobile/utils/config.dart';
import 'package:tembakul_mobile/widgets/shimmer_widget.dart';

class SlidesItemWidget extends StatelessWidget {
  final String url;
  const SlidesItemWidget({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "${Config().urlNewsImg}$url",
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Config().padding),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      ),
      placeholder: (context, url) =>
          Loading().shimmerCustom(height: 300, width: 300),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      width: 300,
      height: 180,
    );
  }
}
