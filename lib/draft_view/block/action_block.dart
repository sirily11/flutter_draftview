import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:draft_view/draft_view/block/callbacks.dart';
import 'package:flutter/cupertino.dart';

class ActionBlock extends BaseBlock {
  final OnTap? onTap;
  final OnDoubleTap? onDoubleTap;
  final OnLongPress? onLongPress;
  final ActionBuilder? actionBuilder;

  ActionBlock({
    required int depth,
    required int start,
    required int end,
    required List<String> inlineStyles,
    required Map<String, dynamic> data,
    required String text,
    required List<String> entityTypes,
    required String blockType,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.actionBuilder,
    List<BaseBlock>? children,
  }) : super(
          depth: depth,
          start: start,
          end: end,
          inlineStyles: inlineStyles,
          data: data,
          text: text,
          entityTypes: entityTypes,
          blockType: blockType,
          children: children,
        );
}
