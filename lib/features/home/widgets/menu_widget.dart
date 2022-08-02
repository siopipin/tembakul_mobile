import 'package:flutter/material.dart';
import 'package:tembakul_mobile/features/home/widgets/menu_item_widget.dart';
import 'package:tembakul_mobile/utils/config.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Config().padding),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: GridView.count(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: (1 / .7),
              mainAxisSpacing: Config().padding,
              children: const <Widget>[
                MenuItemWidget(
                  icon: Icons.app_registration,
                  title: 'Pendaftaran',
                  index: 1,
                ),
                MenuItemWidget(
                  icon: Icons.people,
                  title: 'Data\nPenerima',
                  index: 2,
                ),
                MenuItemWidget(
                  icon: Icons.location_city,
                  title: 'Data\nPerusahaan',
                  index: 3,
                ),
                MenuItemWidget(
                  icon: Icons.location_on,
                  title: 'Lokasi\nPokTan',
                  index: 4,
                ),
                MenuItemWidget(
                  icon: Icons.token_sharp,
                  title: 'Program\nUnggulan',
                  index: 5,
                ),
                MenuItemWidget(
                  icon: Icons.help,
                  title: 'FAQ',
                  index: 6,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
