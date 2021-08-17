import 'package:draft_view/draft_view.dart';
import 'package:draft_view/draft_view/block/blocks/settings_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_data.dart';
import 'blockquote_test.dart';

void main() {
  group("Post settings test", () {
    late BuildContext context;
    Key key = Key("rich-text");

    setUp(() {
      context = MockBuildContext();
    });
    final settings = {
      "settings": [
        {
          "id": "daa1c8fa-d79d-4b0b-a3ac-636746f25d68",
          "name": "人物",
          "description": "",
          "detailSettings": [
            {
              "id": "6221ddf5-81bd-4d23-b0a2-eb10d53397b0",
              "name": "abcde",
              "description": "abcdefg",
            },
          ]
        },
      ]
    };

    test("Simple test1", () async {
      var block = PostSettingsBlock(
        depth: 1,
        start: 0,
        end: 5,
        inlineStyles: [],
        data: {"id": "6221ddf5-81bd-4d23-b0a2-eb10d53397b0"},
        text: "",
        entityTypes: [],
        blockType: "ordered-list-item",
        settings: Settings.fromJson(settings),
      );

      var textSpan = block.render(context);
      expect(textSpan.toPlainText().contains("abcde"), true);
    });
    testWidgets("Simple test2", (tester) async {
      var block = PostSettingsBlock(
        depth: 1,
        start: 0,
        end: 5,
        inlineStyles: [],
        data: {"id": "6221ddf5-81bd-4d23-b0a2-eb10d53397b0"},
        text: "",
        entityTypes: [],
        blockType: "ordered-list-item",
        settings: Settings.fromJson(settings),
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

      final RenderBox box = tester.renderObject(find.byKey(key));

      await tester
          .tapAt(box.localToGlobal(Offset.zero) + const Offset(2.0, 2.0));

      await tester.pumpAndSettle();
      expect(find.text("abcde"), findsOneWidget);
      expect(find.text("abcdefg"), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();
      expect(find.text("abcde"), findsNothing);
      expect(find.text("abcdefg"), findsNothing);
    });
  });
}
