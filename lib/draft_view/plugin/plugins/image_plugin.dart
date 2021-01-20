import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:draft_view/draft_view/block/blocks/image_block.dart';
import 'package:draft_view/draft_view/block/blocks/text_block.dart';
import 'package:draft_view/draft_view/block/callbacks.dart';
import 'package:draft_view/draft_view/plugin/base_plugin.dart';
import 'package:flutter/cupertino.dart';

class ImagePlugin extends BasePlugin {
  final OnTap onTap;
  final OnDoubleTap onDoubleTap;
  final OnLongPress onLongPress;
  final ActionBuilder actionBuilder;

  ImagePlugin(
      {this.onDoubleTap, this.onLongPress, this.onTap, this.actionBuilder})
      : super();

  @override
  get entityRenderFn => {
        "image": ImageBlock(
          depth: 0,
          blockType: '',
          data: {},
          end: 0,
          entityTypes: [],
          inlineStyles: [],
          start: 0,
          text: '',
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          actionBuilder: actionBuilder,
        )
      };
}
