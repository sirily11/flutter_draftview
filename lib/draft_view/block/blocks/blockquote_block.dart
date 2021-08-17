import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter/material.dart';

class BlockQuoteBlock extends BaseBlock {
  BlockQuoteBlock({
    required depth,
    required start,
    required end,
    required List<String> inlineStyles,
    required Map<String, dynamic> data,
    required String text,
    required List<String> entityTypes,
    required String blockType,
    required List<BaseBlock> children,
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
        children: block?.children ?? this.children ?? [],
      );

  @override
  @override
  InlineSpan render(BuildContext context, {List<InlineSpan>? children}) {
    var style = renderStyle(context);
    var text = children?.length == 0 ? textContent : null;

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
            key: Key("block-quote-content-$textContent"),
            text: TextSpan(
              text: text,
              children: children,
              style: style,
            ),
          ),
        ),
      ),
    );
  }
}
