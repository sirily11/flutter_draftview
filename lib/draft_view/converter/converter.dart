import 'dart:convert';

import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:draft_view/draft_view/block/blocks/list_block.dart';
import 'package:draft_view/draft_view/block/blocks/text_block.dart';
import 'package:draft_view/draft_view/block/draft_object.dart';
import 'package:draft_view/draft_view/plugin/base_plugin.dart';

class Converter {
  List<BasePlugin> plugins;
  Map<String, dynamic> draftData;

  Converter({required this.plugins, required this.draftData}) {
    assert(draftData.containsKey('blocks') == true);
    assert(draftData.containsKey('entityMap') == true);
  }

  List<BaseBlock> convert() {
    List<BaseBlock> blocks = [];
    List<BaseBlock> retBlocks = [];
    List<RawDraftContentBlock> draftBlocks = [];
    Map<String, RawDraftEntityKeyStringAny> entityMap = {};

    for (var block in this.draftData['blocks']) {
      var draftBlock = RawDraftContentBlock.fromJson(block);
      draftBlocks.add(draftBlock);
      var hasAdded = false;
      var tmpB = BaseBlock(
        depth: draftBlock.depth.toInt(),
        start: 0,
        end: draftBlock.text.length,
        inlineStyles: [],
        data: draftBlock.data,
        text: draftBlock.text,
        entityTypes: [],
        blockType: draftBlock.type,
      );
      for (var plugin in plugins) {
        if (plugin.blockRenderFn(tmpB)?.containsKey(draftBlock.type) ?? false) {
          var b = plugin
              .blockRenderFn(tmpB, shouldWrite: true)![draftBlock.type]!
              .copyWith(block: tmpB);
          blocks.add(b);
          hasAdded = true;
          break;
        }
      }
      if (!hasAdded) {
        blocks.add(tmpB);
      }
    }

    (draftData['entityMap'] as Map).forEach((key, value) {
      entityMap[key] = RawDraftEntityKeyStringAny.fromJson(value);
    });

    int i = 0;

    while (i < draftBlocks.length) {
      var curDraftBlock = draftBlocks[i];
      var block = blocks[i];
      var prevDraftBlock = i > 1 ? draftBlocks[i - 1] : null;
      var nextDraftBlock =
          i < draftBlocks.length - 1 ? draftBlocks[i + 1] : null;

      var bs = splitBlock(
        block: block,
        entities: curDraftBlock.entityRanges,
        inlines: curDraftBlock.inlineStyleRanges,
        entityMap: entityMap,
      );

      if (block.children != null) {
        if (bs.length > 0) {
          if (bs.first != block) {
            block.children!.addAll(bs);
          }
        }
        retBlocks.add(block);
      } else {
        retBlocks.addAll(bs);
      }

      if (i < draftBlocks.length - 1) {
        if (block is ListBlock) {
          /// If the block is above types, then add nothing
        } else {
          /// Add new line
          if (curDraftBlock.text.isNotEmpty &&
              nextDraftBlock!.text.isNotEmpty) {
            retBlocks.add(NewlineBlock());
          } else if (curDraftBlock.type != nextDraftBlock!.type) {
            retBlocks.add(NewlineBlock());
          } else if (curDraftBlock.text.isEmpty &&
              (prevDraftBlock?.text.isNotEmpty ?? false) &&
              nextDraftBlock.text.isNotEmpty) {
            retBlocks.add(NewlineBlock());
          } else if (curDraftBlock.text.isEmpty &&
              nextDraftBlock.text.isEmpty) {
            retBlocks.add(NewlineBlock());
          }
        }
      }

      i += 1;
    }

    return retBlocks;
  }

  /// split content block into multiple blocks by their [entities] and [inline styles]
  List<BaseBlock> splitBlock({
    required BaseBlock block,
    required List<RawDraftEntityRange> entities,
    required List<RawDraftInlineStyleRange> inlines,
    required Map<String, RawDraftEntityKeyStringAny> entityMap,
  }) {
    List<BaseBlock> retBlocks = [block];
    for (var entity in entities) {
      int start = entity.offset.toInt();
      int end = (start + entity.length).toInt();
      int i = 0;
      while (i < retBlocks.length) {
        var tmpBlock = retBlocks[i];
        if (tmpBlock.withinRange(start, end)) {
          var entityData = entityMap[entity.key];
          var newBlocks = tmpBlock.split(
            depth: tmpBlock.depth,
            start: start,
            end: end,
            entity: entityData?.type,
            data: entityData?.data ?? {},
            plugins: plugins,
          );

          retBlocks = _addBlocksAt(
            index: i,
            blocks: retBlocks,
            newBlocks: newBlocks,
          );
          i += newBlocks.length;
          continue;
        }

        i += 1;
      }
    }

    for (var inline in inlines) {
      int start = inline.offset.toInt();
      int end = (start + inline.length).toInt();
      int i = 0;
      while (i < retBlocks.length) {
        var tmpBlock = retBlocks[i];
        if (tmpBlock.withinRange(start, end)) {
          var newBlocks = tmpBlock.split(
            depth: tmpBlock.depth,
            start: start,
            end: end,
            style: inline.style,
            data: {},
            plugins: plugins,
          );

          retBlocks = _addBlocksAt(
            index: i,
            blocks: retBlocks,
            newBlocks: newBlocks,
          );
          i += newBlocks.length;
          continue;
        }

        i += 1;
      }
    }

    return retBlocks;
  }

  /// Add [newBlocks] to [blocks] at [index]
  List<BaseBlock> _addBlocksAt({
    required int index,
    required List<BaseBlock> blocks,
    required List<BaseBlock> newBlocks,
  }) {
    if (newBlocks.length == 1) {
      blocks[index] = newBlocks.first;
      return blocks;
    }

    var first = blocks.sublist(0, index);
    var middle = blocks.sublist(index + 1);
    List<BaseBlock> mergedBlocks = [...first, ...newBlocks, ...middle];

    return mergedBlocks;
  }
}
