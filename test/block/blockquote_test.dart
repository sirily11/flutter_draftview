import 'package:draft_view/draft_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group("Test blockquote", () {
    final text = "Hello World";
    final inlineStyles = ["BOLD", "ITALIC", "UNDERLINE", "#4caf50"];
     BuildContext context;
    final themeData = ThemeData(
        textTheme: TextTheme(
      headline1: TextStyle(fontSize: 25),
      headline2: TextStyle(fontSize: 24),
      headline3: TextStyle(fontSize: 23),
      headline4: TextStyle(fontSize: 22),
      headline5: TextStyle(fontSize: 21),
      headline6: TextStyle(fontSize: 20),
    ));
    final key = Key("block-quote-content-${text.substring(0, 5)}");

    setUp(() {
      context = MockBuildContext();
    });

    testWidgets("simple test", (tester) async {
      var block = BlockQuoteBlock(
        depth: 0,
        start: 0,
        end: 5,
        inlineStyles: inlineStyles,
        data: {},
        text: text,
        entityTypes: [],
        blockType: "blockquote",
        children: [],
      );

      var component = MaterialApp(
        theme: themeData,
        home: Material(
          child: Builder(
            builder: (context) => RichText(
              text: block.render(context, children: []),
            ),
          ),
        ),
      );
      await tester.pumpWidget(component);
      var textFinder = find.byKey(key);
      var textWidget = tester.element(textFinder).widget as RichText;
      var textSpan = textWidget.text;
      expect(textSpan.toPlainText(), text.substring(0, 5));
      expect(textSpan.style.decoration, TextDecoration.underline);
      expect(textSpan.style.fontWeight, FontWeight.bold);
      expect(textSpan.style.fontStyle, FontStyle.italic);
      expect(textSpan.style.color, HexColor.fromHex("#4caf50"));
    });
  });
}
