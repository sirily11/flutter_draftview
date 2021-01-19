import 'package:draft_view/draft_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group("Test without rendering", () {
    MockBuildContext context;

    setUp(() {
      context = MockBuildContext();
    });

    test("Simple test", () {
      var text = "Hello World";
      var block = BaseBlock(
        depth: 0,
        start: 0,
        end: text.length,
        inlineStyles: [],
        data: {},
        text: text,
        entityTypes: [],
        blockType: "unstyled",
      );
      var textspan = block.render(context);
      expect(textspan.toPlainText(), text);
      expect(textspan.style.decoration, TextDecoration.none);
      expect(textspan.style.fontWeight, FontWeight.normal);
      expect(textspan.style.fontStyle, FontStyle.normal);
    });

    test("Simple test with style", () {
      var text = "Hello World";
      var block = BaseBlock(
        depth: 0,
        start: 0,
        end: 5,
        inlineStyles: ["BOLD", "ITALIC", "UNDERLINE", "#4caf50"],
        data: {},
        text: text,
        entityTypes: [],
        blockType: "unstyled",
      );
      var textspan = block.render(context);
      expect(textspan.toPlainText(), text.substring(0, 5));
      expect(textspan.style.decoration, TextDecoration.underline);
      expect(textspan.style.fontWeight, FontWeight.bold);
      expect(textspan.style.fontStyle, FontStyle.italic);
      expect(textspan.style.color, HexColor.fromHex("#4caf50"));
    });
  });
}
