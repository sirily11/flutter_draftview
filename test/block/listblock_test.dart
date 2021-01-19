import 'package:draft_view/draft_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group("Test listTreeNode", () {
    var listblock1 = ListBlock(
      depth: 0,
      start: 0,
      end: 0,
      inlineStyles: [],
      data: {},
      text: "1",
      entityTypes: [],
      blockType: "ordered-list-item",
      isOrderedList: true,
      order: 0,
    );

    var listblock2 = ListBlock(
      depth: 0,
      start: 0,
      end: 0,
      inlineStyles: [],
      data: {},
      text: "1",
      entityTypes: [],
      blockType: "ordered-list-item",
      order: 0,
      isOrderedList: true,
    );

    var listblock3 = ListBlock(
      depth: 0,
      start: 0,
      end: 0,
      inlineStyles: [],
      data: {},
      text: "1",
      entityTypes: [],
      blockType: "ordered-list-item",
      order: 0,
      isOrderedList: true,
    );

    var listblock4 = ListBlock(
      depth: 0,
      start: 0,
      end: 0,
      inlineStyles: [],
      data: {},
      text: "1",
      entityTypes: [],
      blockType: "ordered-list-item",
      isOrderedList: true,
      order: 0,
    );

    ListTreeNode root;

    setUp(() {
      root = ListTreeNode(isRoot: true);
    });

    test("simple tree", () {
      /// 1
      /// 2
      /// 3
      /// 4
      var node1 = root.addChild(listblock1);
      var node2 = root.addChild(listblock2);
      var node3 = root.addChild(listblock3);
      var node4 = root.addChild(listblock4);
      expect(node1.order, 1);
      expect(node2.order, 2);
      expect(node3.order, 3);
      expect(node4.order, 4);

      expect(node1.depth, 0);
      expect(node2.depth, 0);
      expect(node3.depth, 0);
      expect(node4.depth, 0);
    });

    test("multiple depth tree", () {
      /// 1
      /// 2 3
      /// 4
      var node1 = root.addChild(listblock1);
      var node2 = root.addChild(listblock2);
      var node3 = node2.addChild(listblock3);
      var node4 = root.addChild(listblock4);
      expect(node1.order, 1);
      expect(node2.order, 2);
      expect(node3.order, 1);
      expect(node4.order, 3);

      expect(node1.depth, 0);
      expect(node2.depth, 0);
      expect(node3.depth, 1);
      expect(node4.depth, 0);
    });
  });

  group("Test render list", () {
    final text = "Hello World";
    final inlineStyles = ["BOLD", "ITALIC", "UNDERLINE", "#4caf50"];
    BuildContext context;

    setUp(() {
      context = MockBuildContext();
    });
    test("Ordered list", () {
      var block = ListBlock(
        order: 1,
        depth: 1,
        start: 0,
        end: 5,
        inlineStyles: inlineStyles,
        data: {},
        text: text,
        entityTypes: [],
        blockType: "ordered-list-item",
        isOrderedList: true,
      );

      var textSpan = block.render(context);
      expect(textSpan.toPlainText(), "1. ${text.substring(0, 5)}\n");
      expect(textSpan.style.decoration, TextDecoration.underline);
      expect(textSpan.style.fontWeight, FontWeight.bold);
      expect(textSpan.style.fontStyle, FontStyle.italic);
      expect(textSpan.style.color, HexColor.fromHex("#4caf50"));
    });
    test("Ordered list 2", () {
      var block = ListBlock(
        order: 1,
        depth: 2,
        start: 0,
        end: 5,
        inlineStyles: inlineStyles,
        data: {},
        text: text,
        entityTypes: [],
        blockType: "ordered-list-item",
        isOrderedList: true,
      );

      var textSpan = block.render(context);
      expect(textSpan.toPlainText(), "      1. ${text.substring(0, 5)}\n");
      expect(textSpan.style.decoration, TextDecoration.underline);
      expect(textSpan.style.fontWeight, FontWeight.bold);
      expect(textSpan.style.fontStyle, FontStyle.italic);
      expect(textSpan.style.color, HexColor.fromHex("#4caf50"));
    });

    test("Unordered list 1", () {
      var block = ListBlock(
        order: 1,
        depth: 1,
        start: 0,
        end: 5,
        inlineStyles: inlineStyles,
        data: {},
        text: text,
        entityTypes: [],
        blockType: "unordered-list-item",
        isOrderedList: false,
      );

      var textSpan = block.render(context);
      expect(textSpan.toPlainText(), "- ${text.substring(0, 5)}\n");
      expect(textSpan.style.decoration, TextDecoration.underline);
      expect(textSpan.style.fontWeight, FontWeight.bold);
      expect(textSpan.style.fontStyle, FontStyle.italic);
      expect(textSpan.style.color, HexColor.fromHex("#4caf50"));
    });

    test("Unordered list 2", () {
      var block = ListBlock(
        order: 1,
        depth: 2,
        start: 0,
        end: 5,
        inlineStyles: inlineStyles,
        data: {},
        text: text,
        entityTypes: [],
        blockType: "unordered-list-item",
        isOrderedList: false,
      );

      var textSpan = block.render(context);
      expect(textSpan.toPlainText(), "      - ${text.substring(0, 5)}\n");
      expect(textSpan.style.decoration, TextDecoration.underline);
      expect(textSpan.style.fontWeight, FontWeight.bold);
      expect(textSpan.style.fontStyle, FontStyle.italic);
      expect(textSpan.style.color, HexColor.fromHex("#4caf50"));
    });
  });
}
