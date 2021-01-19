import 'package:draft_view/draft_view/block/blocks/audio_block.dart';
import 'package:draft_view/draft_view/block/blocks/image_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'blockquote_test.dart';

void main() {
  group("Audio test", () {
     BuildContext context;
    Key key = Key("rich-text");

    setUp(() {
      context = MockBuildContext();
    });

    testWidgets("simple test", (tester) async {
      var block = AudioBlock(
        depth: 0,
        start: 0,
        end: 1,
        inlineStyles: [],
        data: {"src": "abc.com"},
        text: "",
        entityTypes: [],
        blockType: "audio",
      );

      var component = MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => RichText(
              key: key,
              text: block.render(context),
            ),
          ),
        ),
      );

      await tester.pumpWidget(component);
      expect(find.text("abc.com"), findsOneWidget);
    });
  });
}
