import 'package:flutter/material.dart';
import 'package:tembakul_mobile/utils/config.dart';

class MenuItemWidget extends StatelessWidget {
  final String? title;
  final IconData? icon;
  const MenuItemWidget({Key? key, @required this.title, @required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(Config().padding + 2),
          decoration: BoxDecoration(
              color: Config().colorSecondary,
              borderRadius: BorderRadius.circular(Config().padding / 2)),
          child: Icon(
            icon,
            color: Config().colorItem,
          ),
        ),
        Text(
          title!,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: Config().fontSizeTiny),
        )
      ],
    );
  }
}
