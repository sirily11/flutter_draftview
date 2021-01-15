import 'dart:math';

import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:draft_view/draft_view/block/draft_object.dart';
import 'package:draft_view/draft_view/converter/converter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_data.dart';

void main() {
  group("Test converter split block function", () {
    late BaseBlock baseBlock;
    late Map<String, RawDraftEntityKeyStringAny> entityMap;

    setUp(() {
      var text = "Hello World";
      baseBlock = BaseBlock(
        start: 0,
        end: text.length,
        inlineStyles: [],
        data: {},
        text: text,
        entityTypes: [],
        blockType: "unstyled",
      );

      entityMap = {
        "0": RawDraftEntityKeyStringAny(
          data: {"url": "bing.com"},
          mutability: "MUTABLE",
          type: "Link",
        ),
        "1": RawDraftEntityKeyStringAny(
          data: {"url": "abs.com"},
          mutability: "MUTABLE",
          type: "Link",
        )
      };
    });

    test("Split 1", () {
      List<RawDraftEntityRange> entityRanges = [
        RawDraftEntityRange(key: "0", length: 5, offset: 0),
        RawDraftEntityRange(key: "1", length: 6, offset: 5)
      ];

      var converter = Converter(plugins: [], draftData: testData);
      var blocks = converter.splitBlock(
          block: baseBlock,
          entities: entityRanges,
          inlines: [],
          entityMap: entityMap);
      expect(blocks.length, 2);
      expect(blocks[0].entityTypes, ['Link']);
      expect(blocks[1].entityTypes, ['Link']);
    });

    test("Split 2", () {
      List<RawDraftInlineStyleRange> inlines = [
        RawDraftInlineStyleRange(length: 5, offset: 0, style: "BOLD"),
        RawDraftInlineStyleRange(length: 6, offset: 5, style: "ITALIC"),
      ];
      var converter = Converter(plugins: [], draftData: testData);
      var blocks = converter.splitBlock(
        block: baseBlock,
        entities: [],
        inlines: inlines,
        entityMap: entityMap,
      );
      expect(blocks.length, 2);
      expect(blocks[0].entityTypes, []);
      expect(blocks[1].entityTypes, []);
      expect(blocks[0].inlineStyles, ['BOLD']);
      expect(blocks[1].inlineStyles, ['ITALIC']);
    });

    test("Split 3", () {
      List<RawDraftEntityRange> entityRanges = [
        RawDraftEntityRange(key: "0", length: 5, offset: 0),
        RawDraftEntityRange(key: "1", length: 6, offset: 5)
      ];
      List<RawDraftInlineStyleRange> inlines = [
        RawDraftInlineStyleRange(length: 5, offset: 0, style: "BOLD"),
        RawDraftInlineStyleRange(length: 6, offset: 5, style: "ITALIC"),
      ];
      var converter = Converter(plugins: [], draftData: testData);
      var blocks = converter.splitBlock(
        block: baseBlock,
        entities: entityRanges,
        inlines: inlines,
        entityMap: entityMap,
      );
      expect(blocks.length, 2);
      expect(blocks[0].entityTypes, ['Link']);
      expect(blocks[1].entityTypes, ['Link']);
      expect(blocks[0].inlineStyles, ['BOLD']);
      expect(blocks[1].inlineStyles, ['ITALIC']);
    });

    test("Split 4", () {
      List<RawDraftEntityRange> entityRanges = [
        RawDraftEntityRange(key: "0", length: 5, offset: 0),
        RawDraftEntityRange(key: "1", length: 6, offset: 5)
      ];
      List<RawDraftInlineStyleRange> inlines = [
        RawDraftInlineStyleRange(length: 3, offset: 2, style: "BOLD"),
        RawDraftInlineStyleRange(length: 6, offset: 5, style: "ITALIC"),
      ];
      var converter = Converter(plugins: [], draftData: testData);
      var blocks = converter.splitBlock(
        block: baseBlock,
        entities: entityRanges,
        inlines: inlines,
        entityMap: entityMap,
      );
      expect(blocks.length, 3);
    });
  });
}
