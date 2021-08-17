import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:draft_view/draft_view/block/blocks/image_block.dart';
import 'package:draft_view/draft_view/block/blocks/link_block.dart';
import 'package:draft_view/draft_view/block/blocks/text_block.dart';
import 'package:draft_view/draft_view/block/callbacks.dart';
import 'package:draft_view/draft_view/plugin/base_plugin.dart';
import 'package:flutter/cupertino.dart';

class LinkPlugin extends BasePlugin {
  final OnTap onTap;
  final OnDoubleTap onDoubleTap;
  final OnLongPress onLongPress;
  final ActionBuilder actionBuilder;

  LinkPlugin(
      {required this.onDoubleTap,
      required this.onLongPress,
      required this.onTap,
      required this.actionBuilder})
      : super();

  @override
  get entityRenderFn => {
        "LINK": LinkBlock(
          depth: 0,
          blockType: '',
          data: {},
          end: 0,
          entityTypes: [],
          inlineStyles: [],
          start: 0,
          text: '',
          children: [],
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          actionBuilder: actionBuilder,
        )
      };
}
