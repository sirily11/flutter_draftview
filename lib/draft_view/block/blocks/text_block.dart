import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter/material.dart';

class TextBlock extends BaseBlock {
  final int start;
  final int end;
  final String text;

  /// Block Type
  final String blockType;

  /// Inline styles
  final List<String> inlineStyles;

  /// Entity type
  final List<String> entityTypes;
  final Map<String, dynamic> data;

  TextBlock({
    required this.start,
    required this.end,
    required this.inlineStyles,
    required this.data,
    required this.text,
    required this.entityTypes,
    required this.blockType,
  }) : super(
          start: start,
          end: end,
          inlineStyles: inlineStyles,
          data: data,
          text: text,
          entityTypes: entityTypes,
          blockType: blockType,
        );
}

class NewlineBlock extends BaseBlock {
  NewlineBlock()
      : super(
          start: 0,
          end: 0,
          inlineStyles: [],
          data: {},
          text: "",
          entityTypes: [],
          blockType: "newline",
        );

  @override
  InlineSpan render(BuildContext context) {
    return TextSpan(text: "\n\n", style: renderStyle(context));
  }
}
