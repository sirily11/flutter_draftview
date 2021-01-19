import 'dart:io' as io;

import 'package:draft_view/draft_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../utils.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group("Test render link ", () {
    final text = "Hello World";
    final inlineStyles = ["BOLD", "ITALIC", "UNDERLINE", "#4caf50"];
     BuildContext context;
    final key = Key("rich-text");

    setUp(() {
      context = MockBuildContext();
    });
    test("simple link", () {
      var block = LinkBlock(
        depth: 1,
        start: 0,
        end: 5,
        inlineStyles: inlineStyles,
        data: {
          "url": {"title": "abc", "summary": "", "image": "", "link": "abc.com"}
        },
        text: text,
        entityTypes: [],
        blockType: "ordered-list-item",
        children: [],
      );

      var textSpan = block.render(context);
      expect(textSpan.toPlainText(), "${text.substring(0, 5)}");
      expect(textSpan.style.decoration, TextDecoration.underline);
      expect(textSpan.style.fontWeight, FontWeight.bold);
      expect(textSpan.style.fontStyle, FontStyle.italic);
    });

    testWidgets("click on link without details", (tester) async {
      var block = LinkBlock(
        depth: 1,
        start: 0,
        end: 5,
        inlineStyles: inlineStyles,
        data: {"url": "abc.com"},
        text: text,
        entityTypes: [],
        blockType: "ordered-list-item",
        children: [],
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
      expect(find.text("No title"), findsOneWidget);
    });

    testWidgets("click on link with details", (tester) async {
      var block = LinkBlock(
        depth: 1,
        start: 0,
        end: 5,
        inlineStyles: inlineStyles,
        data: {
          "url": {
            "title": "abc",
            "summary": "hhh",
            "link": "abc.com",
          }
        },
        text: text,
        entityTypes: [],
        blockType: "ordered-list-item",
        children: [],
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
      expect(find.text("abc"), findsOneWidget);
      expect(find.text("hhh"), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();
      expect(find.text("abc"), findsNothing);
      expect(find.text("hhh"), findsNothing);
    });
  });
}
