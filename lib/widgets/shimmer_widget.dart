import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:tembakul_mobile/utils/config.dart';

class Loading {
  shimmerCustom({required double height, required double width}) {
    return Shimmer.fromColors(
      baseColor: Config().shimmerColor,
      highlightColor: Config().shimmerColor,
      enabled: true,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(Config().padding),
        width: width,
        height: height,
      ),
    );
  }
}
