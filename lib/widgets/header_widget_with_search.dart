import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:tembakul_mobile/features/lokasi/providers/lokasi_provider.dart';
import 'package:tembakul_mobile/features/penerima/models/penerima_model.dart';
import 'package:provider/provider.dart';
import 'package:tembakul_mobile/utils/config.dart';

class HeaderWithSearchWidget extends StatefulWidget {
  final String title;
  final String desc;
  final String textSearch;
  final IconData icon;
  final bool isAutoComplete;
  const HeaderWithSearchWidget({
    Key? key,
    required this.title,
    required this.desc,
    required this.textSearch,
    required this.icon,
    this.isAutoComplete = false,
  }) : super(key: key);

  @override
  State<HeaderWithSearchWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWithSearchWidget> {
  GlobalKey<AutoCompleteTextFieldState<Data>> key = GlobalKey();
  AutoCompleteTextField? searchTextField;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final watchLokasi = context.watch<LokasiProvider>();
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(Config().padding + 5),
        bottomRight: Radius.circular(Config().padding + 5),
      ),
      child: Container(
        padding: EdgeInsets.all(Config().padding),
        decoration: BoxDecoration(
          color: Config().colorPrimary,
        ),
        width: double.infinity,
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
            if (widget.isAutoComplete)
              watchLokasi.statePenerima == StatePenerimaLokasi.loaded
                  ? searchTextField = AutoCompleteTextField<Data>(
                      style:
                          const TextStyle(color: Colors.black, fontSize: 16.0),
                      controller: controller,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: const EdgeInsets.all(16),
                        filled: true,
                        fillColor: Config().colorItem,
                        hintText: widget.textSearch,
                        hintStyle: TextStyle(fontSize: Config().fontSizeH2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      itemSubmitted: (item) {
                        setState(() {
                          searchTextField!.textField!.controller!.text =
                              item.asalKelompokTani!;
                          if (item.lat != null) {
                            watchLokasi.setCenterLat = double.parse(item.lat);
                            watchLokasi.setCenterLatLong =
                                double.parse(item.latLong);
                            watchLokasi.movePosition();
                          }
                        });
                      },
                      clearOnSubmit: false,
                      key: key,
                      suggestions: watchLokasi.dataPenerima.data!,
                      itemBuilder: (context, item) {
                        return Container(
                          padding: EdgeInsets.all(Config().padding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                item.asalKelompokTani!,
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              Text(
                                item.name!,
                              )
                            ],
                          ),
                        );
                      },
                      itemSorter: (a, b) {
                        return a.asalKelompokTani!
                            .compareTo(b.asalKelompokTani!);
                      },
                      itemFilter: (item, query) {
                        return item.asalKelompokTani!
                            .toLowerCase()
                            .startsWith(query.toLowerCase());
                      })
                  : defaultSearchBar(context)
            else
              defaultSearchBar(context),
            SizedBox(height: Config().padding),
          ],
        ),
      ),
    );
  }

  defaultSearchBar(BuildContext context) {
    return TextField(
      textAlign: TextAlign.left,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: widget.textSearch,
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
    );
  }
}
