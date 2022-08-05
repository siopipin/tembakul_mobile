import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tembakul_mobile/features/pengajuan/providers/pengajuan_providers.dart';
import 'package:tembakul_mobile/utils/config.dart';
import 'package:tembakul_mobile/widgets/button_widget.dart';
import 'package:tembakul_mobile/widgets/textfield_custom_widget.dart';
import 'package:tembakul_mobile/widgets/title_section_widget.dart';
import 'package:provider/provider.dart';

class FormPengajuanWidget extends StatelessWidget {
  const FormPengajuanWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watchPengajuan = context.watch<PengajuanProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleSectionWidget(
            title: "Informasi", icon: Icons.person_pin_outlined),
        SizedBox(height: Config().padding),
        TextFieldCustomWidget(
          textHint: "Nama",
          ctrl: watchPengajuan.ctrlNama,
          icon: Icons.person_pin_circle_rounded,
        ),
        SizedBox(height: Config().padding / 2),
        TextFieldCustomWidget(
          textHint: "Nama Kelompok Tani",
          ctrl: watchPengajuan.ctrlAsalPokTan,
          icon: Icons.home_work,
        ),
        SizedBox(height: Config().padding / 2),
        TextFieldCustomWidget(
            textHint: "Alamat",
            ctrl: watchPengajuan.ctrlAddress,
            icon: Icons.location_on_rounded),
        SizedBox(height: Config().padding / 2),
        TextFieldCustomWidget(
          textHint: "Email",
          ctrl: watchPengajuan.ctrlEmail,
          icon: Icons.alternate_email,
        ),
        SizedBox(height: Config().padding / 2),
        TextFieldCustomWidget(
          textHint: "HP",
          isNumber: true,
          ctrl: watchPengajuan.ctrlHP,
          icon: Icons.phone_android,
        ),
        SizedBox(height: Config().padding / 2),
        Row(
          children: [
            ButtonWidget(
              text:
                  watchPengajuan.fileName.isEmpty ? 'Pilih File' : "Ganti File",
              width: 150,
              function: () async {
                watchPengajuan.setFile = await FilePicker.platform.pickFiles(
                    type: FileType.custom, allowedExtensions: ['pdf', 'doc']);
              },
            ),
            Text(
              watchPengajuan.fileName.isEmpty
                  ? 'belum ada file terpilih..'
                  : "  ${watchPengajuan.fileName}",
              style: TextStyle(
                  fontSize: Config().fontSizeTiny, fontStyle: FontStyle.italic),
            )
          ],
        ),
        SizedBox(height: Config().padding / 2),
        ButtonWidget(
          text: "Submit",
          function: () async {
            if (watchPengajuan.ctrlAddress.text.isEmpty ||
                watchPengajuan.ctrlAsalPokTan.text.isEmpty ||
                watchPengajuan.ctrlEmail.text.isEmpty ||
                watchPengajuan.ctrlHP.text.isEmpty ||
                watchPengajuan.ctrlHP.text.isEmpty) {
              Fluttertoast.showToast(
                  msg: "Lengkapi Data sebelum mengirim berkas");
            } else if (watchPengajuan.fileName.isEmpty) {
              Fluttertoast.showToast(
                  msg: "Silahkan pilih berkas sebelum submit");
            } else {
              await watchPengajuan.postPengajuan(
                nama: watchPengajuan.ctrlNama.text,
                asal: watchPengajuan.ctrlAsalPokTan.text,
                alamat: watchPengajuan.ctrlAddress.text,
                email: watchPengajuan.ctrlEmail.text,
                hp: watchPengajuan.ctrlHP.text,
              );
            }
          },
        ),
      ],
    );
  }
}
