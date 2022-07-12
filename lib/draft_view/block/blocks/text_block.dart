import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter/material.dart';

class TextBlock extends BaseBlock {
  TextBlock({
    required int depth,
    required int start,
    required int end,
    required List<String> inlineStyles,
    required Map<String, dynamic> data,
    required String text,
    required List<String> entityTypes,
    required String blockType,
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

  TextBlock copyWith({BaseBlock? block}) => TextBlock(
        depth: block?.depth ?? this.depth,
        start: block?.start ?? this.start,
        end: block?.end ?? this.end,
        inlineStyles: block?.inlineStyles ?? this.inlineStyles,
        entityTypes: block?.entityTypes ?? this.entityTypes,
        data: block?.data ?? this.data,
        text: block?.text ?? this.text,
        blockType: block?.blockType ?? this.blockType,
      );
}

class NewlineBlock extends BaseBlock {
  NewlineBlock()
      : super(
          depth: 0,
          start: 0,
          end: 0,
          inlineStyles: [],
          data: {},
          text: "",
          entityTypes: [],
          blockType: "newline",
        );

  @override
  InlineSpan render(BuildContext context, {List<InlineSpan>? children}) {
    return TextSpan(text: "\n", style: renderStyle(context));
  }
}
