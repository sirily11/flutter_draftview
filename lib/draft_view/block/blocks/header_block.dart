import 'dart:convert';
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

    switch (level) {
      case 1:
        var textStyle = Theme.of(context).textTheme.headline1!.copyWith(
              fontWeight: prevStyle.fontWeight,
              fontStyle: prevStyle.fontStyle,
              decoration: prevStyle.decoration,
              color: textColor(context),
            );
        return textStyle;

      case 2:
        var textStyle = Theme.of(context).textTheme.headline2!.copyWith(
              fontWeight: prevStyle.fontWeight,
              fontStyle: prevStyle.fontStyle,
              decoration: prevStyle.decoration,
              color: textColor(context),
            );

        return textStyle;

      case 3:
        var textStyle = Theme.of(context).textTheme.headline3!.copyWith(
              fontWeight: prevStyle.fontWeight,
              fontStyle: prevStyle.fontStyle,
              decoration: prevStyle.decoration,
              color: textColor(context),
            );
        return textStyle;
      case 4:
        var textStyle = Theme.of(context).textTheme.headline4!.copyWith(
              fontWeight: prevStyle.fontWeight,
              fontStyle: prevStyle.fontStyle,
              decoration: prevStyle.decoration,
              color: textColor(context),
            );
        return textStyle;
      case 5:
        var textStyle = Theme.of(context).textTheme.headline5!.copyWith(
              fontWeight: prevStyle.fontWeight,
              fontStyle: prevStyle.fontStyle,
              decoration: prevStyle.decoration,
              color: textColor(context),
            );
        return textStyle;
      default:
        var textStyle = Theme.of(context).textTheme.headline6!.copyWith(
              fontWeight: prevStyle.fontWeight,
              fontStyle: prevStyle.fontStyle,
              decoration: prevStyle.decoration,
              color: textColor(context),
            );
        return textStyle;
    }
  }

  @override
  InlineSpan render(BuildContext context, {List<InlineSpan>? children}) {
    return TextSpan(text: textContent, style: renderStyle(context));
  }
}

class RawDraftEntityT {
  final Map<String, dynamic> data;
  final String mutability;
  final String type;

  RawDraftEntityT({
    required this.data,
    required this.mutability,
    required this.type,
  });

  RawDraftEntityT copyWith({
    Map<String, dynamic>? data,
    String? mutability,
    String? type,
  }) =>
      RawDraftEntityT(
        data: data ?? this.data,
        mutability: mutability ?? this.mutability,
        type: type ?? this.type,
      );

  factory RawDraftEntityT.fromRawJson(String str) =>
      RawDraftEntityT.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RawDraftEntityT.fromJson(Map<String, dynamic> json) =>
      RawDraftEntityT(
        data: Map.from(json["data"])
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        mutability: json["mutability"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "data": Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "mutability": mutability,
        "type": type,
      };
}

enum ComposedEntityType { IMAGE, LINK, PHOTO, TOKEN }

enum CoreDraftBlockType {
  ATOMIC,
  BLOCKQUOTE,
  CODE_BLOCK,
  HEADER_FIVE,
  HEADER_FOUR,
  HEADER_ONE,
  HEADER_SIX,
  HEADER_THREE,
  HEADER_TWO,
  ORDERED_LIST_ITEM,
  PARAGRAPH,
  UNORDERED_LIST_ITEM,
  UNSTYLED
}
