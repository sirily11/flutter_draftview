import 'package:draft_view/draft_view.dart';
import 'package:example/draft_data.dart';
import 'package:example/post_settings_data.dart';
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
            bodyText1: TextStyle(height: 2, fontSize: 17),
          ),
        ),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DraftView(
                rawDraftData: data,
                plugins: [
                  TextPlugin(),
                  BlockQuotePlugin(),
                  HeaderPlugin(),
                  ImagePlugin(),
                  PostSettingsPlugin(rawSettings: settings)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
