import 'package:draft_view/draft_view.dart';
import 'package:example/draft_data.dart';
import 'package:flutter/material.dart';

class Demo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DraftView(
        rawDraftData: data,
        plugins: [TextPlugin()],
      ),
    );
  }
}
