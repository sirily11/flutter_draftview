import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter/material.dart';

class HeaderBlock extends BaseBlock {
  final int start;
  final int end;
  final String text;
  final int depth;
  final List<BaseBlock> children;

  /// Block Type
  final String blockType;

  /// Inline styles
  final List<String> inlineStyles;

  /// Entity type
  final List<String> entityTypes;
  final Map<String, dynamic> data;
  final int level;

  HeaderBlock({
    required this.depth,
    required this.start,
    required this.end,
    required this.inlineStyles,
    required this.data,
    required this.text,
    required this.entityTypes,
    required this.blockType,
    required this.level,
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
          children: [],
        );

  HeaderBlock copyWith({BaseBlock? block}) => HeaderBlock(
        depth: block?.depth ?? depth,
        start: block?.start ?? this.start,
        end: block?.end ?? this.end,
        inlineStyles: block?.inlineStyles ?? this.inlineStyles,
        entityTypes: block?.entityTypes ?? this.entityTypes,
        data: block?.data ?? this.data,
        text: block?.text ?? this.text,
        blockType: block?.blockType ?? this.blockType,
        level: this.level,
        children: block?.children ?? children,
      );

  @override
  TextStyle renderStyle(BuildContext context) {
    var prevStyle = super.renderStyle(context);

    switch (level) {
      case 1:
        var textStyle = Theme.of(context).textTheme.headline1!.copyWith(
              fontWeight: prevStyle.fontWeight,
              fontStyle: prevStyle.fontStyle,
              decoration: prevStyle.decoration,
            );
        return textStyle;

      case 2:
        var textStyle = Theme.of(context).textTheme.headline2!.copyWith(
              fontWeight: prevStyle.fontWeight,
              fontStyle: prevStyle.fontStyle,
              decoration: prevStyle.decoration,
            );

        return textStyle;

      case 3:
        var textStyle = Theme.of(context).textTheme.headline3!.copyWith(
              fontWeight: prevStyle.fontWeight,
              fontStyle: prevStyle.fontStyle,
              decoration: prevStyle.decoration,
            );
        return textStyle;
      case 4:
        var textStyle = Theme.of(context).textTheme.headline4!.copyWith(
              fontWeight: prevStyle.fontWeight,
              fontStyle: prevStyle.fontStyle,
              decoration: prevStyle.decoration,
            );
        return textStyle;
      case 5:
        var textStyle = Theme.of(context).textTheme.headline5!.copyWith(
              fontWeight: prevStyle.fontWeight,
              fontStyle: prevStyle.fontStyle,
              decoration: prevStyle.decoration,
            );
        return textStyle;
      default:
        var textStyle = Theme.of(context).textTheme.headline6!.copyWith(
              fontWeight: prevStyle.fontWeight,
              fontStyle: prevStyle.fontStyle,
              decoration: prevStyle.decoration,
            );
        return textStyle;
    }
  }

  @override
  InlineSpan render(BuildContext context, {List<InlineSpan>? children}) {
    return TextSpan(text: "$text", style: renderStyle(context));
  }
}
