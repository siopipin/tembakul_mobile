import 'package:flutter/material.dart';
import 'package:tembakul_mobile/utils/config.dart';

class BannerHeaderWidget extends StatefulWidget {
  const BannerHeaderWidget({Key? key}) : super(key: key);

  @override
  State<BannerHeaderWidget> createState() => _BannerHeaderWidgetState();
}

class _BannerHeaderWidgetState extends State<BannerHeaderWidget> {
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
          const SizedBox(height: 50),
          //Wellcome Message
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Selamat Datang!',
                      style: TextStyle(
                          color: Config().fontPrimaryWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: Config().fontSizeH1)),
                  SizedBox(height: Config().padding / 4),
                  Text(
                    'di Tembakul Apps',
                    style: TextStyle(color: Config().fontSecondary),
                  )
                ],
              ),
              CircleAvatar(
                backgroundColor: Config().colorSecondary,
                child: Icon(
                  Icons.apps,
                  color: Config().colorItem,
                ),
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
          SizedBox(
            height: Config().padding,
          )
        ],
      ),
    );
  }
}