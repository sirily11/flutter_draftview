import 'dart:math';

import 'package:draft_view/draft_view.dart';
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

  group("Test converter convert function", () {
    test("convert 1", () {
      var converter = Converter(plugins: [TextPlugin()], draftData: testData);
      var blocks = converter.convert();

      expect(blocks.length > 2, true);
    });

    test("convert 2", () {
      var data = {
        "blocks": [
          {
            "key": "7rk7h",
            "text":
                "了一个火堆过去，把莉莱辛辛苦苦做的雪人弄融化了。莉莱哭了，从家跑出去，边哭边摘手套，唱”let it go，let it go， can hold it back anymore”。正是这一段凄惨的故事，正是莉莱这悲惨的人生的转折点。她离开了那个家，离开了自己心爱的剑客，离开了这个悲伤的小镇。这是在她十岁的那一年，而这一天也恰巧是她的生日。",
            "type": "unstyled",
            "depth": 0,
            "inlineStyleRanges": [
              {"offset": 43, "length": 47, "style": "BOLD"}
            ],
            "entityRanges": [],
            "data": {}
          },
        ],
        "entityMap": {}
      };

      var converter = Converter(plugins: [TextPlugin()], draftData: data);
      var blocks = converter.convert();
      expect(blocks.length, 3);
    });
  });
}
