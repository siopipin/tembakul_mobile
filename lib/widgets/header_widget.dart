import 'package:flutter/material.dart';

import 'package:tembakul_mobile/utils/config.dart';

class HeaderCustomeWidget extends StatefulWidget {
  final String title;
  final String desc;
  final IconData icon;
  const HeaderCustomeWidget({
    Key? key,
    required this.title,
    required this.desc,
    required this.icon,
  }) : super(key: key);

  @override
  State<HeaderCustomeWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderCustomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Config().padding),
      decoration: BoxDecoration(
          color: Config().colorPrimary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Config().padding + 5),
            bottomRight: Radius.circular(Config().padding + 5),
          )),
      child: Column(
        children: [
          //Wellcome Message
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,
                        style: TextStyle(
                            color: Config().fontPrimaryWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: Config().fontSizeH1)),
                    SizedBox(height: Config().padding / 4),
                    Text(
                      widget.desc,
                      style: TextStyle(color: Config().fontSecondary),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Config().colorSecondary,
                    child: Icon(
                      widget.icon,
                      color: Config().colorItem,
                    ),
                  ),
                  SizedBox(width: Config().padding - 6),
                ],
              )
            ],
          ),
          SizedBox(height: Config().padding),
        ],
      ),
    );
  }
}
