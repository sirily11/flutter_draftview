import 'dart:convert';

import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:draft_view/draft_view/block/draft_object.dart';
import 'package:draft_view/draft_view/plugin/base_plugin.dart';

class Converter {
  List<BasePlugin> plugins;
  Map<String, dynamic> draftData;

  Converter({required this.plugins, required this.draftData});

  List<BaseBlock> convert() {
    List<BaseBlock> blocks = [];
    List<RawDraftContentBlock> draftBlocks = [];
    Map<String, RawDraftEntityKeyStringAny> entityMap = {};

    for (var block in this.draftData['blocks']) {
      draftBlocks.add(RawDraftContentBlock.fromJson(block));
    }

    (draftData['entityMap'] as Map).forEach((key, value) {
      entityMap[key] = RawDraftEntityKeyStringAny.fromJson(value);
    });


    return blocks;
  }
}
