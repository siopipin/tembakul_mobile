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
          textHint: "Nama Kelompok Tani",
          ctrl: watchPengajuan.ctrlAsalPokTan,
          icon: Icons.home_work,
        ),
        SizedBox(height: Config().padding / 2),
        TextFieldCustomWidget(
          textHint: "Nama Ketua Pengurus",
          ctrl: watchPengajuan.ctrlNama,
          icon: Icons.person_pin_circle_rounded,
        ),
        SizedBox(height: Config().padding / 2),
        TextFieldCustomWidget(
          textHint: "Jumlah Anggota",
          ctrl: watchPengajuan.ctrlJumlahAnggota,
          icon: Icons.people,
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
        SizedBox(height: Config().padding / 2 + 6),
        Text("Legalitas (Akta Pendirian / Terdaftar di SIMLUHTAN)"),
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
            Expanded(
                child: Text(
              watchPengajuan.fileName.isEmpty
                  ? 'belum ada file terpilih..'
                  : "  ${watchPengajuan.fileName}",
              style: TextStyle(
                  fontSize: Config().fontSizeTiny, fontStyle: FontStyle.italic),
            ))
          ],
        ),
        SizedBox(height: Config().padding / 2 + 6),
        Divider(),
        Text("Proposal (PDF/JPG)"),
        ButtonWidget(
          text: watchPengajuan.fileName2.isEmpty ? 'Pilih File' : "Ganti File",
          width: 150,
          function: () async {
            watchPengajuan.setFile2 = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf', 'doc'],
                allowMultiple: true);
          },
        ),
        if (watchPengajuan.fileName2.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(watchPengajuan.fileResult2.count, (index) {
              var data = watchPengajuan.fileResult2.files[index];
              return Row(
                children: [
                  SizedBox(width: 10),
                  Icon(
                    Icons.file_present_rounded,
                    size: 13,
                  ),
                  Text(data.name)
                ],
              );
            }).toList(),
          )
        else
          Container(),
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
                jumlahAnggota: watchPengajuan.ctrlJumlahAnggota.text,
                alamat: watchPengajuan.ctrlAddress.text,
                email: watchPengajuan.ctrlEmail.text,
                hp: watchPengajuan.ctrlHP.text,
              );
            }
          },
        ),
        SizedBox(height: 50),
      ],
    );
  }
}
