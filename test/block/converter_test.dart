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

    test("Test convert with newline", () {
      var data = {
        "blocks": [
          {
            "key": "755mk",
            "text":
                "莉莱心想，这个貌似是叫2ao的游戏，好像是一个设定在名叫天辉夜宴的魔法世界。斯文应该很喜欢。结果就在这个时候，电视上又传来一个新闻：“刚刚发售的2ao游戏，因为制作人茅场晶彦的关系，多达20000名玩家被困在游戏中无法登出。”莉莱看到了电视上一闪而过的斯文的名字，哭了出来。立马跑回自己的小镇（十年未回的），见到了斯文。只见斯文虚弱的躺在床上，脸色十分不好。因为斯文家里不是很有钱，没办法给他最新型的阴养供给机，所以他已经长时间没怎么好好吃饭了。一想到这样，莉莱泣不成声，跑到了街上。就在这个时候，遇到在那里的凤凰院凶真（我）。凤凰院说：你怎么了，为啥哭了？”莉莱说，从小我就因为体型被同学欺负，被家长嫌弃，被姐姐玩弄。现在连我唯一的依靠——斯文，也可能",
            "type": "unstyled",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [],
            "data": {}
          },
          {
            "key": "f1o2m",
            "text": "",
            "type": "unstyled",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [],
            "data": {}
          },
          {
            "key": "aljgi",
            "text":
                "要离我而去了，为什么，为什么，为什么！！老天要这么玩弄我！凤凰院说：别哭啊，小妹妹，现在还有一个解决方法，你要不要听？ 什么方法！快说！莉莱急破脸，呐喊到。凤凰院胸针（我）扔出了个海报，上面写的叫厌食症互助小组。你去那看看，一定能找到和你志同道合的人的。",
            "type": "unstyled",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [],
            "data": {}
          },
          {
            "key": "67icf",
            "text":
                "在那个小组里，莉莱很快的认识到了很多和自己有这同样问题的女生，她们大多有着和自己相同的经历。莉莱很开心能够来到这里，原来世界不只是自己有着这样的遭遇。莉莱在一次见面会上说道：”谢谢你 米拉娜，谢谢你露娜，谢谢你卓尔飞侠，谢谢你邪影芳龄，不是你们我不可能坚持下来。“说这便和其他的哦朋友一起",
            "type": "unstyled",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [],
            "data": {}
          }
        ],
        "entityMap": {}
      };

      var converter = Converter(plugins: [TextPlugin()], draftData: data);

      var blocks = converter.convert();
      expect(blocks.length, 5);
      expect(blocks[0] is TextBlock, true);
    });
  });

  group("Test convert image", () {
    test("Convert image 1", () {
      var data = {
        "blocks": [
          {
            "key": "69rah",
            "text": " ",
            "type": "atomic",
            "depth": 0,
            "inlineStyleRanges": [],
            "entityRanges": [
              {"offset": 0, "length": 1, "key": 0}
            ],
            "data": {}
          },
        ],
        "entityMap": {
          "0": {
            "type": "image",
            "mutability": "IMMUTABLE",
            "data": {
              "src":
                  "https://sirileepage-website-data.s3.amazonaws.com/static/image/2020/06/25/cover-13.png",
              "id": 51,
              "alignment": "center",
              "description": "2077 Art Online 示意图"
            }
          }
        }
      };

      var converter =
          Converter(plugins: [TextPlugin(), ImagePlugin()], draftData: data);
      var blocks = converter.convert();

      expect(blocks.length, 1);
      expect(blocks[0] is ImageBlock, true);
    });
  });
}
