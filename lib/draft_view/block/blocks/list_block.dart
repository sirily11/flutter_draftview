import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter/material.dart';

class ListBlock extends BaseBlock {
  final int start;
  final int end;
  final String text;
  final int depth;

  /// Block Type
  final String blockType;

  /// Inline styles
  final List<String> inlineStyles;

  /// Entity type
  final List<String> entityTypes;
  final Map<String, dynamic> data;
  final int order;
  final bool isOrderedList;

  ListBlock({
    required this.depth,
    required this.start,
    required this.end,
    required this.inlineStyles,
    required this.data,
    required this.text,
    required this.entityTypes,
    required this.blockType,
    required this.order,
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
        depth: block?.depth ?? depth,
        start: block?.start ?? this.start,
        end: block?.end ?? this.end,
        inlineStyles: block?.inlineStyles ?? this.inlineStyles,
        entityTypes: block?.entityTypes ?? this.entityTypes,
        data: block?.data ?? this.data,
        text: block?.text ?? this.text,
        blockType: block?.blockType ?? this.blockType,
        order: this.order,
        isOrderedList: isOrderedList,
      );

  @override
  InlineSpan render(BuildContext context, {List<InlineSpan>? children}) {
    return TextSpan(
      text: "${isOrderedList ? "$order. " : "- "} $text",
      style: renderStyle(context),
    );
  }
}
