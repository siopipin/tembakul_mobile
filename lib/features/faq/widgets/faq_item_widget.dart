import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tembakul_mobile/features/faq/providers/faq_provider.dart';
import 'package:tembakul_mobile/utils/config.dart';

class FaqItemWidget extends StatelessWidget {
  const FaqItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watchFaq = context.watch<FAQProvider>();

    return Column(
      children: watchFaq.dataFaq.data!
          .map(
            (e) => ExpansionTile(
              leading: const Icon(Icons.question_mark_outlined),
              title: Text(e.title ?? '-'),
              children: <Widget>[
                ListTile(title: Text(e.description ?? '-')),
              ],
            ),
          )
          .toList(),
    );
  }
}
