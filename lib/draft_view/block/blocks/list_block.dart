import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter/material.dart';

class ListBlock extends BaseBlock {
  /// List block's style
  final bool isOrderedList;

  /// Current order of the list. Ex: 1.; 2.; 3.;
  final int order;

  ListBlock({
    required this.order,
    required int depth,
    required int start,
    required int end,
    required List<String> inlineStyles,
    required Map<String, dynamic> data,
    required String text,
    required List<String> entityTypes,
    required String blockType,
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
        depth: block?.depth ?? this.depth,
        start: block?.start ?? this.start,
        end: block?.end ?? this.end,
        inlineStyles: block?.inlineStyles ?? this.inlineStyles,
        entityTypes: block?.entityTypes ?? this.entityTypes,
        data: block?.data ?? this.data,
        text: block?.text ?? this.text,
        blockType: block?.blockType ?? this.blockType,
        isOrderedList: this.isOrderedList,
        order: this.order,
      );

  String getDepthSpacing() {
    String spacing = "";
    int i = 1;
    while (i < depth) {
      spacing += '      ';
      i += 1;
    }
    return spacing;
  }

  @override
  InlineSpan render(BuildContext context, {List<InlineSpan>? children}) {
    return TextSpan(
      text:
          "${getDepthSpacing()}${isOrderedList ? "$order." : "-"} $textContent\n",
      style: renderStyle(context),
    );
  }
}
