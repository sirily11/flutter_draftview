import 'package:draft_view/draft_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Test header block", () {
    final themeData = ThemeData(
        textTheme: TextTheme(
      headline1: TextStyle(fontSize: 25),
      headline2: TextStyle(fontSize: 24),
      headline3: TextStyle(fontSize: 23),
      headline4: TextStyle(fontSize: 22),
      headline5: TextStyle(fontSize: 21),
      headline6: TextStyle(fontSize: 20),
    ));
    final text = "Hello World";
    final key = Key("rich-text");
    testWidgets("Header 1", (tester) async {
      var block = HeaderBlock(
          depth: 0,
          start: 0,
          end: text.length,
          inlineStyles: ["BOLD", "ITALIC", "UNDERLINE", "#4caf50"],
          data: {},
          text: text,
          entityTypes: [],
          blockType: 'header-one',
          level: 1,
          children: []);
      var component = MaterialApp(
        theme: themeData,
        home: Material(
          child: Builder(
            builder: (context) => RichText(
              key: key,
              text: block.render(context),
            ),
          ),
        ),
      );

      await tester.pumpWidget(component);
      var textFinder = find.byKey(key);
      var textWidget = tester.element(textFinder).widget as RichText;
      var textSpan = textWidget.text;
      expect(textSpan.style.fontSize, 25);
      expect(textSpan.toPlainText(), text);
      expect(textSpan.style.decoration, TextDecoration.underline);
      expect(textSpan.style.fontWeight, FontWeight.bold);
      expect(textSpan.style.fontStyle, FontStyle.italic);
      expect(textSpan.style.color, HexColor.fromHex("#4caf50"));
    });

    testWidgets("Header 2", (tester) async {
      var block = HeaderBlock(
          depth: 0,
          start: 0,
          end: text.length,
          inlineStyles: ["BOLD", "ITALIC", "UNDERLINE", "#4caf50"],
          data: {},
          text: text,
          entityTypes: [],
          blockType: 'header-one',
          level: 2,
          children: []);
      var component = MaterialApp(
        theme: themeData,
        home: Material(
          child: Builder(
            builder: (context) => RichText(
              key: key,
              text: block.render(context),
            ),
          ),
        ),
      );

      await tester.pumpWidget(component);
      var textFinder = find.byKey(key);
      var textWidget = tester.element(textFinder).widget as RichText;
      var textSpan = textWidget.text;
      expect(textSpan.style.fontSize, 24);
      expect(textSpan.toPlainText(), text);
      expect(textSpan.style.decoration, TextDecoration.underline);
      expect(textSpan.style.fontWeight, FontWeight.bold);
      expect(textSpan.style.fontStyle, FontStyle.italic);
      expect(textSpan.style.color, HexColor.fromHex("#4caf50"));
    });

    testWidgets("Header 3", (tester) async {
      var block = HeaderBlock(
          depth: 0,
          start: 0,
          end: text.length,
          inlineStyles: ["BOLD", "ITALIC", "UNDERLINE", "#4caf50"],
          data: {},
          text: text,
          entityTypes: [],
          blockType: 'header-one',
          level: 3,
          children: []);
      var component = MaterialApp(
        theme: themeData,
        home: Material(
          child: Builder(
            builder: (context) => RichText(
              key: key,
              text: block.render(context),
            ),
          ),
        ),
      );

      await tester.pumpWidget(component);
      var textFinder = find.byKey(key);
      var textWidget = tester.element(textFinder).widget as RichText;
      var textSpan = textWidget.text;
      expect(textSpan.style.fontSize, 23);
      expect(textSpan.toPlainText(), text);
      expect(textSpan.style.decoration, TextDecoration.underline);
      expect(textSpan.style.fontWeight, FontWeight.bold);
      expect(textSpan.style.fontStyle, FontStyle.italic);
      expect(textSpan.style.color, HexColor.fromHex("#4caf50"));
    });

    testWidgets("Header 4", (tester) async {
      var block = HeaderBlock(
          depth: 0,
          start: 0,
          end: text.length,
          inlineStyles: ["BOLD", "ITALIC", "UNDERLINE", "#4caf50"],
          data: {},
          text: text,
          entityTypes: [],
          blockType: 'header-one',
          level: 4,
          children: []);
      var component = MaterialApp(
        theme: themeData,
        home: Material(
          child: Builder(
            builder: (context) => RichText(
              key: key,
              text: block.render(context),
            ),
          ),
        ),
      );

      await tester.pumpWidget(component);
      var textFinder = find.byKey(key);
      var textWidget = tester.element(textFinder).widget as RichText;
      var textSpan = textWidget.text;
      expect(textSpan.style.fontSize, 22);
      expect(textSpan.toPlainText(), text);
      expect(textSpan.style.decoration, TextDecoration.underline);
      expect(textSpan.style.fontWeight, FontWeight.bold);
      expect(textSpan.style.fontStyle, FontStyle.italic);
      expect(textSpan.style.color, HexColor.fromHex("#4caf50"));
    });

    testWidgets("Header 5", (tester) async {
      var block = HeaderBlock(
          depth: 0,
          start: 0,
          end: text.length,
          inlineStyles: ["BOLD", "ITALIC", "UNDERLINE", "#4caf50"],
          data: {},
          text: text,
          entityTypes: [],
          blockType: 'header-one',
          level: 5,
          children: []);
      var component = MaterialApp(
        theme: themeData,
        home: Material(
          child: Builder(
            builder: (context) => RichText(
              key: key,
              text: block.render(context),
            ),
          ),
        ),
      );

      await tester.pumpWidget(component);
      var textFinder = find.byKey(key);
      var textWidget = tester.element(textFinder).widget as RichText;
      var textSpan = textWidget.text;
      expect(textSpan.style.fontSize, 21);
      expect(textSpan.toPlainText(), text);
      expect(textSpan.style.decoration, TextDecoration.underline);
      expect(textSpan.style.fontWeight, FontWeight.bold);
      expect(textSpan.style.fontStyle, FontStyle.italic);
      expect(textSpan.style.color, HexColor.fromHex("#4caf50"));
    });

    testWidgets("Header 6", (tester) async {
      var block = HeaderBlock(
          depth: 0,
          start: 0,
          end: text.length,
          inlineStyles: ["BOLD", "ITALIC", "UNDERLINE", "#4caf50"],
          data: {},
          text: text,
          entityTypes: [],
          blockType: 'header-one',
          level: 6,
          children: []);
      var component = MaterialApp(
        theme: themeData,
        home: Material(
          child: Builder(
            builder: (context) => RichText(
              key: key,
              text: block.render(context),
            ),
          ),
        ),
      );

      await tester.pumpWidget(component);
      var textFinder = find.byKey(key);
      var textWidget = tester.element(textFinder).widget as RichText;
      var textSpan = textWidget.text;
      expect(textSpan.style.fontSize, 20);
      expect(textSpan.toPlainText(), text);
      expect(textSpan.style.decoration, TextDecoration.underline);
      expect(textSpan.style.fontWeight, FontWeight.bold);
      expect(textSpan.style.fontStyle, FontStyle.italic);
      expect(textSpan.style.color, HexColor.fromHex("#4caf50"));
    });
  });
}
