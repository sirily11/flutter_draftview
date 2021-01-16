import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:draft_view/draft_view/plugin/plugins/list_plugin.dart';
import 'package:flutter/material.dart';

class ListBlock extends BaseBlock {
  final int start;
  final int end;
  final String text;
  final int depth;
  final ListTreeNode? current;

  /// Block Type
  final String blockType;

  /// Inline styles
  final List<String> inlineStyles;

  /// Entity type
  final List<String> entityTypes;
  final Map<String, dynamic> data;
  final bool isOrderedList;

  ListBlock({
    this.current,
    required this.depth,
    required this.start,
    required this.end,
    required this.inlineStyles,
    required this.data,
    required this.text,
    required this.entityTypes,
    required this.blockType,
    required this.isOrderedList,
  }) : super(
          depth: depth,
          start: start,
          end: end,
          inlineStyles: inlineStyles,
          data: data,
          text: text,
          entityTypes: entityTypes,
          blockType: blockType,
        );

  ListBlock copyWith({BaseBlock? block}) => ListBlock(
        current: this.current,
        depth: this.depth,
        start: block?.start ?? this.start,
        end: block?.end ?? this.end,
        inlineStyles: block?.inlineStyles ?? this.inlineStyles,
        entityTypes: block?.entityTypes ?? this.entityTypes,
        data: block?.data ?? this.data,
        text: block?.text ?? this.text,
        blockType: block?.blockType ?? this.blockType,
        isOrderedList: isOrderedList,
      );

  String getDepthSpacing() {
    String spacing = "";
    int i = 0;
    while (i < depth) {
      spacing += ' ';
      i += 1;
    }

    return spacing;
  }

  @override
  InlineSpan render(BuildContext context, {List<InlineSpan>? children}) {
    return TextSpan(
      text: "${getDepthSpacing()}- $text",
      style: renderStyle(context),
    );
  }
}
