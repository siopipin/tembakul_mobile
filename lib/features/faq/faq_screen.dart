import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tembakul_mobile/features/faq/providers/faq_provider.dart';
import 'package:tembakul_mobile/features/faq/widgets/faq_item_widget.dart';
import 'package:tembakul_mobile/utils/config.dart';
import 'package:tembakul_mobile/widgets/error_widget.dart';
import 'package:tembakul_mobile/widgets/header_widget.dart';
import 'package:tembakul_mobile/widgets/shimmer_widget.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<FAQProvider>().initial());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ"),
        elevation: 0,
      ),
      body: Scrollbar(
          child: RefreshIndicator(
        onRefresh: () async {
          await context.read<FAQProvider>().initial();
        },
        child: ListView(padding: EdgeInsets.zero, children: [
          //header
          const HeaderCustomeWidget(
              title: 'FAQ',
              desc: 'List Informasi Pertanyaan yang sering ditanya',
              icon: Icons.question_answer_sharp),

          //body
          SizedBox(height: Config().padding),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Config().padding),
            child: listFaq(context),
          )
        ]),
      )),
    );
  }

  listFaq(BuildContext context) {
    final watchFaq = context.watch<FAQProvider>();

    switch (watchFaq.stateFaq) {
      case StateFAQ.error:
        return const NotFoundWidget();
      case StateFAQ.loading:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Config().padding),
          child: Column(
              children: List.generate(
                  3,
                  (index) => Padding(
                        padding: EdgeInsets.only(bottom: Config().padding),
                        child: Loading().shimmerCustom(
                            height: 80,
                            width: MediaQuery.of(context).size.width),
                      ))),
        );
      case StateFAQ.loaded:
        if (watchFaq.dataFaq.data!.isEmpty) {
          return const NotFoundWidget(
            msg: "List FAQ Tidak Tersedia!",
          );
        } else {
          return const FaqItemWidget();
        }
      default:
        return Container();
    }
  }
}
