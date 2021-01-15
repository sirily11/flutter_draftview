import 'package:draft_view/draft_view.dart';
import 'package:example/draft_data.dart';
import 'package:flutter/material.dart';

class Demo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Theme(
        data: ThemeData(
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 30, color: Colors.black),
            headline2: TextStyle(fontSize: 25, color: Colors.black),
            headline3: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        child: DraftView(
          rawDraftData: data,
          plugins: [TextPlugin(), HeaderPlugin()],
        ),
      ),
    );
  }
}
