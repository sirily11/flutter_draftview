import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Test basic block ", () {
    test("Create a new block and split", () {
      var text = "Hello World";
      var block = BaseBlock(
        start: 0,
        end: text.length,
        styles: [],
        data: {},
        text: text,
        entityTypes: [],
      );

      var blocks = block.split(0, 5, null, null, {}, []);
      expect(blocks.length, 2);
      expect(blocks[0].textContent, "Hello");
      expect(blocks[1].textContent, " World");
    });

    test("Create a new block and split 2", () {
      var text = "Hello World";
      var block = BaseBlock(
        start: 0,
        end: text.length,
        styles: [],
        data: {},
        text: text,
        entityTypes: [],
      );

      var blocks = block.split(2, 4, null, null, {}, []);
      expect(blocks.length, 3);
      expect(blocks[0].textContent, "He");
      expect(blocks[1].textContent, "ll");
      expect(blocks[2].textContent, "o World");
    });

    test("Create a new block and split 3", () {
      var text = "Hello World";
      var block = BaseBlock(
        start: 0,
        end: text.length,
        styles: [],
        data: {},
        text: text,
        entityTypes: [],
      );

      var blocks = block.split(2, text.length, null, null, {}, []);
      expect(blocks.length, 2);
      expect(blocks[0].textContent, "He");
      expect(blocks[1].textContent, "llo World");
    });

    test("Create a new block and split 4", () {
      var text = "Hello World";
      var block = BaseBlock(
        start: 0,
        end: text.length,
        styles: [],
        data: {},
        text: text,
        entityTypes: [],
      );

      var blocks = block.split(2, 4, null, null, {}, []);
      //He ll o_World
      var newBlocks = blocks[1].split(1, 5, null, null, {}, []);
      expect(newBlocks.length, 1);

      newBlocks = blocks[1].split(1, 4, null, null, {}, []);
      expect(newBlocks.length, 1);

      newBlocks = blocks[1].split(3, 4, null, null, {}, []);
      expect(newBlocks.length, 2);
    });
  });
}
