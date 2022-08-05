import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tembakul_mobile/features/penerima/providers/penerima_provider.dart';
import 'package:tembakul_mobile/utils/config.dart';

class PenerimaItemWidget extends StatelessWidget {
  const PenerimaItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watchPenerima = context.watch<PenerimaProvider>();

    return Column(
      children: watchPenerima.penerimaData.data!
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
                                  //tanggal dan status
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        e.tahunAnggaran ?? '',
                                        style: TextStyle(
                                          fontSize: Config().fontSizeTiny,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.all(
                                              Config().padding / 4),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Config().padding / 3),
                                              color: e.status == 1
                                                  ? Config().colorPrimary
                                                  : e.status == 0
                                                      ? Colors.orange
                                                      : e.status == 2
                                                          ? Colors.purple
                                                          : Colors.red),
                                          child: Text(
                                            e.status == 1
                                                ? 'Diterima'
                                                : e.status == 0
                                                    ? 'Diproses'
                                                    : e.status == 2
                                                        ? 'Perbaikan'
                                                        : 'Ditolak',
                                            style: TextStyle(
                                                fontSize: Config().fontSizeTiny,
                                                color:
                                                    Config().fontPrimaryWhite),
                                          )),
                                    ],
                                  ), //nama asal poktan

                                  //Header
                                  Text(
                                    e.asalKelompokTani ?? '-',
                                    style: TextStyle(
                                      fontSize: Config().fontSizeH2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: Config().padding / 2),
                                  Text(e.name ?? '-'),
                                  Text(e.hp ?? '-'),

                                  //Jenis Bantuan
                                  Divider(),
                                  e.jenisBantuan!.isNotEmpty
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Jenis Bantuan',
                                              style: TextStyle(
                                                fontSize: Config().fontSizeH2,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Column(
                                              children: e.jenisBantuan!
                                                  .asMap()
                                                  .entries
                                                  .map((e) => Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          //index & Nama
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  '${e.key + 1}. '),
                                                              Text(e.value
                                                                      .jenisBantuan ??
                                                                  '-'),
                                                            ],
                                                          ),

                                                          //Satuan & unit
                                                          Row(
                                                            children: [
                                                              Text(
                                                                e.value.unit
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                  width: Config()
                                                                          .padding /
                                                                      3),
                                                              Text(e.value
                                                                      .satuan ??
                                                                  '')
                                                            ],
                                                          )
                                                        ],
                                                      ))
                                                  .toList(),
                                            )
                                          ],
                                        )
                                      : Container()
                                ]),
                          )));
                },
                child: Container(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.tahunAnggaran ?? '',
                              style: TextStyle(
                                fontSize: Config().fontSizeTiny,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              e.asalKelompokTani ?? '-',
                              style: TextStyle(
                                fontSize: Config().fontSizeH2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: Config().padding / 2),
                            Text(e.name ?? '-'),
                            Text(e.hp ?? '-'),
                          ],
                        ),

                        //PDF & status
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    padding:
                                        EdgeInsets.all(Config().padding / 4),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Config().padding / 3),
                                        color: e.status == 1
                                            ? Config().colorPrimary
                                            : e.status == 0
                                                ? Colors.orange
                                                : e.status == 2
                                                    ? Colors.purple
                                                    : Colors.red),
                                    child: Text(
                                      e.status == 1
                                          ? 'Diterima'
                                          : e.status == 0
                                              ? 'Diproses'
                                              : e.status == 2
                                                  ? 'Perbaikan'
                                                  : 'Ditolak',
                                      style: TextStyle(
                                          fontSize: Config().fontSizeTiny,
                                          color: Config().fontPrimaryWhite),
                                    )),
                                Icon(
                                  Icons.picture_as_pdf,
                                  size: 40,
                                  color: Config().colorSecondary,
                                )
                              ],
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded)
                          ],
                        )
                      ]),
                ),
              ))
          .toList(),
    );
  }
}
