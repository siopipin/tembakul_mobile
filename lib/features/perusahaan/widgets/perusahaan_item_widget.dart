import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tembakul_mobile/features/perusahaan/providers/perusahaan_provider.dart';
import 'package:tembakul_mobile/utils/config.dart';

class PerusahaanItemWidget extends StatelessWidget {
  const PerusahaanItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watchPerusahaan = context.watch<PerusahaanProvider>();

    return Column(
      children: watchPerusahaan.dataPerusahaan.data!
          .map((e) => GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Config().padding)),
                      builder: ((context) => Container(
                            padding: EdgeInsets.all(Config().padding),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // title dan alamat
                                  Text(
                                    e.title.toString(),
                                    style: TextStyle(
                                      fontSize: Config().fontSizeTiny,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Text(
                                    e.address ?? '-',
                                    style: TextStyle(
                                      fontSize: Config().fontSizeH2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  //Jenis Bantuan
                                  Divider(),
                                  Text('Deskripsi'),
                                  Text(
                                    e.description.toString(),
                                    style: TextStyle(
                                      fontSize: Config().fontSizeTiny,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Jenis Bantuan: ',
                                        style: TextStyle(
                                            fontSize: Config().fontSizeH2,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(e.jenisBantuan ?? '-'),
                                    ],
                                  )
                                ]),
                          )));
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(Config().padding),
                  margin: EdgeInsets.only(bottom: Config().padding - 6),
                  decoration: BoxDecoration(
                      color: Config().colorItem,
                      borderRadius: BorderRadius.circular(
                        Config().padding,
                      )),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Detail
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.title ?? '-',
                                style: TextStyle(
                                  fontSize: Config().fontSizeH2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: Config().padding / 2),
                              Text(
                                e.address ?? '-',
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ],
                          ),
                        ),
                        //Arrow detail
                        const Icon(Icons.arrow_forward_ios_rounded)
                      ]),
                ),
              ))
          .toList(),
    );
  }
}
