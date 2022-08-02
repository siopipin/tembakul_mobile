import 'package:flutter/material.dart';
import 'package:tembakul_mobile/utils/config.dart';

class HeaderBannerWidget extends StatelessWidget {
  const HeaderBannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset('assets/images/logo3D.png', width: 250),
          Text(
            Config().titleApp,
            style: TextStyle(
                fontSize: Config().fontSizeH1, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
