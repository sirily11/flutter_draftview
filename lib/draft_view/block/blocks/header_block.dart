import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter/material.dart';

class HeaderBlock extends BaseBlock {
  /// Entity type
  final int level;

  HeaderBlock({
    required int depth,
    required int start,
    required int end,
    required List<String> inlineStyles,
    required Map<String, dynamic> data,
    required String text,
    required List<String> entityTypes,
    required String blockType,
    required this.level,
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

  HeaderBlock copyWith({BaseBlock? block}) => HeaderBlock(
        depth: block?.depth ?? this.depth,
        start: block?.start ?? this.start,
        end: block?.end ?? this.end,
        inlineStyles: block?.inlineStyles ?? this.inlineStyles,
        entityTypes: block?.entityTypes ?? this.entityTypes,
        data: block?.data ?? this.data,
        text: block?.text ?? this.text,
        blockType: block?.blockType ?? this.blockType,
        level: this.level,
        children: block?.children ?? this.children ?? [],
      );

  @override
  TextStyle renderStyle(BuildContext context) {
    var prevStyle = super.renderStyle(context);
    TextStyle headeline;
    var textTheme = Theme.of(context).textTheme;
    if (level == 1) {
      headeline = textTheme.headline1!;
    } else if (level == 2) {
      headeline = textTheme.headline2!;
    } else if (level == 3) {
      headeline = textTheme.headline3!;
    } else if (level == 4) {
      headeline = textTheme.headline4!;
    } else if (level == 5) {
      headeline = textTheme.headline5!;
    } else {
      headeline = textTheme.headline6!;
    }
    return headeline.copyWith(
      fontWeight: prevStyle.fontWeight,
      fontStyle: prevStyle.fontStyle,
      decoration: prevStyle.decoration,
      color: textColor(context),
    );
  }

  @override
  InlineSpan render(BuildContext context, {List<InlineSpan>? children}) {
    return TextSpan(text: textContent, style: renderStyle(context));
  }
}
