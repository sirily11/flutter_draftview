import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter/material.dart';

class BlockQuoteBlock extends BaseBlock {
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
  final List<BaseBlock> children;

  BlockQuoteBlock({
    required this.depth,
    required this.start,
    required this.end,
    required this.inlineStyles,
    required this.data,
    required this.text,
    required this.entityTypes,
    required this.blockType,
    required this.children,
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

  BlockQuoteBlock copyWith({BaseBlock? block}) => BlockQuoteBlock(
        depth: block?.depth ?? this.depth,
        start: block?.start ?? this.start,
        end: block?.end ?? this.end,
        inlineStyles: block?.inlineStyles ?? this.inlineStyles,
        entityTypes: block?.entityTypes ?? this.entityTypes,
        data: block?.data ?? this.data,
        text: block?.text ?? this.text,
        blockType: block?.blockType ?? this.blockType,
        children: block?.children ?? this.children,
      );

  @override
  @override
  InlineSpan render(BuildContext context, {List<InlineSpan>? children}) {
    var style = Theme.of(context).textTheme.bodyText1;

    return WidgetSpan(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(width: 10, color: Theme.of(context).primaryColor),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
              text: children?.length == 0 ? text : null,
              children: children,
              style: style,
            ),
          ),
        ),
      ),
    );
  }
}
