import 'package:flutter/material.dart';
import 'package:tembakul_mobile/utils/config.dart';

class TitleSectionWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  const TitleSectionWidget({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: EdgeInsets.only(left: Config().padding),
        margin: EdgeInsets.only(bottom: Config().padding),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: Config().padding / 4),
              padding: EdgeInsets.all(Config().padding / 5),
              decoration: BoxDecoration(
                  color: Config().colorSecondary,
                  borderRadius: BorderRadius.circular(Config().padding / 2)),
              child: Icon(
                icon,
                color: Config().colorItem,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: Config().fontSizeH1),
            )
          ],
        ));
  }
}
