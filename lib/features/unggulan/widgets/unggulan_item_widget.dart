import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tembakul_mobile/features/unggulan/providers/unggulan_provider.dart';
import 'package:tembakul_mobile/utils/config.dart';
import 'package:tembakul_mobile/widgets/shimmer_widget.dart';

class UnggulanItemWidget extends StatelessWidget {
  const UnggulanItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watchUnggulan = context.watch<UnggulanProvider>();

    return Column(
      children: watchUnggulan.dataUnggulan.data!
          .map((e) => Padding(
                padding: EdgeInsets.only(bottom: Config().padding),
                child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Config().padding)),
                          builder: ((context) => Container(
                                padding: EdgeInsets.all(Config().padding),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // title dan alamat
                                      Text(
                                        e.title.toString(),
                                        style: TextStyle(
                                          fontSize: Config().fontSizeTiny,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),

                                      //Jenis Bantuan
                                      Divider(),
                                      Text(
                                        e.description ?? '-',
                                        style: TextStyle(
                                          fontSize: Config().fontSizeH2,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                              )));
                    },
                    child: Row(
                      children: [
                        //images news
                        CachedNetworkImage(
                          imageUrl:
                              "${Config().urlAllImg}${e.img ?? 'tembakul.jpeg'}",
                          imageBuilder: (context, imageProvider) => Container(
                            height: 100,
                            width: 110,
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
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          height: 100,
                          width: 110,
                        ),
                        Expanded(
                          child: Container(
                            height: 100,
                            padding: EdgeInsets.all(Config().padding),
                            decoration: BoxDecoration(
                                color: Config().colorItem,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Config().padding),
                                  bottomRight:
                                      Radius.circular(Config().padding),
                                )),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //Detail
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e.title ?? '-',
                                          style: TextStyle(
                                            fontSize: Config().fontSizeH2,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: Config().padding / 2),
                                        Expanded(
                                            child: Text(
                                                e.description!.length > 70
                                                    ? e.description!
                                                        .substring(0, 59)
                                                    : e.description ?? '-')),
                                      ],
                                    ),
                                  ),

                                  //Arrow detail
                                  const Icon(Icons.arrow_forward_ios_rounded)
                                ]),
                          ),
                        )
                      ],
                    )),
              ))
          .toList(),
    );
  }
}
