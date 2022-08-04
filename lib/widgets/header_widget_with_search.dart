import 'package:flutter/material.dart';

import 'package:tembakul_mobile/utils/config.dart';

class HeaderWithSearchWidget extends StatefulWidget {
  final String title;
  final String desc;
  final IconData icon;
  const HeaderWithSearchWidget({
    Key? key,
    required this.title,
    required this.desc,
    required this.icon,
  }) : super(key: key);

  @override
  State<HeaderWithSearchWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWithSearchWidget> {
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
          SizedBox(height: Config().padding * 2),
          //Seachbar
          TextField(
            textAlign: TextAlign.left,
            // controller: searchCtrl,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Cari PokTan',
              hintStyle: TextStyle(fontSize: Config().fontSizeH2),
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              contentPadding: const EdgeInsets.all(16),
              fillColor: Config().colorItem,
            ),
          ),
          SizedBox(height: Config().padding),
        ],
      ),
    );
  }
}
