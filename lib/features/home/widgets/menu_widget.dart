import 'package:flutter/material.dart';
import 'package:tembakul_mobile/features/home/providers/home_provider.dart';
import 'package:tembakul_mobile/features/home/widgets/menu_item_widget.dart';
import 'package:tembakul_mobile/utils/config.dart';
import 'package:provider/provider.dart';
import 'package:tembakul_mobile/widgets/dialog_widget.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watchHome = context.watch<HomeProvider>();
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
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (watchHome.isLoggedIn) {
                      print('klik registrasi');
                    } else {
                      showCustomDialog(context);
                    }
                  },
                  child: MenuItemWidget(
                    icon: Icons.app_registration,
                    title: 'Pendaftaran',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (watchHome.isLoggedIn) {
                      print('klik Data Penerima');
                    } else {
                      showCustomDialog(context);
                    }
                  },
                  child: MenuItemWidget(
                    icon: Icons.people,
                    title: 'Data\nPenerima',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (watchHome.isLoggedIn) {
                      print('Data Perusahaan');
                    } else {
                      showCustomDialog(context);
                    }
                  },
                  child: MenuItemWidget(
                    icon: Icons.location_city,
                    title: 'Data\nPerusahaan',
                  ),
                ),
                MenuItemWidget(
                  icon: Icons.location_on,
                  title: 'Lokasi\nPokTan',
                ),
                MenuItemWidget(
                  icon: Icons.token_sharp,
                  title: 'Program\nUnggulan',
                ),
                MenuItemWidget(
                  icon: Icons.help,
                  title: 'FAQ',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
