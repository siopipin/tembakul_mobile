import 'package:flutter/material.dart';
import 'package:tembakul_mobile/utils/config.dart';

class NotFoundWidget extends StatelessWidget {
  final String msg;
  const NotFoundWidget(
      {Key? key, this.msg = "Something was wrong,\npull down to refresh"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.error,
        ),
        Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: Config().fontSizeTiny,
              color: Config().fontPrimaryBlack),
        )
      ],
    );
  }
}
