import 'dart:convert';
import 'package:draft_view/draft_view/plugin/base_plugin.dart';
import 'package:flutter/material.dart';
import './extensions.dart';

class BaseBlock {
  /// Block's start
  final int start;

  /// block's end
  final int end;

  /// Text content
  final String text;

  /// Draft js property. Starts at 0;
  final int depth;

  /// Block Type
  final String blockType;

  /// Inline styles
  final List<String> inlineStyles;

  /// Entity type
  final List<String> entityTypes;

  /// Block's data. Usually is image's src
  final Map<String, dynamic> data;

  List<BaseBlock>? children;

  BaseBlock({
    required this.depth,
    required this.start,
    required this.end,
    required this.inlineStyles,
    required this.data,
    required this.text,
    required this.entityTypes,
    required this.blockType,
    this.children,
  });

  BaseBlock copyWith({BaseBlock? block}) => BaseBlock(
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

  /// If the range within the current block's range
  bool withinRange(int start, int end) {
    if (start == end) {
      return false;
    }

    if (start <= this.start) {
      if (end > this.start) {
        return true;
      }
    } else if (end >= this.end) {
      if (start < this.end) {
        return true;
      }
    } else if (start > this.start) {
      if (end < this.end) {
        return true;
      }
    }

    return false;
  }

  /// Get text content based on the start and end
  String get textContent {
    return text.substring(start, end);
  }

  /// Add inline style to the block
  List<String> addStyle(String? style) {
    var copiedStyles = (jsonDecode(jsonEncode(this.inlineStyles)) as List)
        .map((e) => e as String)
        .toList();
    if (style != null) {
      return copiedStyles..add(style);
    } else {
      return copiedStyles;
    }
  }

  /// Add entity type to the block
  List<String> addEntityType(String? entity) {
    List<String> copiedTypes =
        (jsonDecode(jsonEncode(this.entityTypes)) as List)
            .map((e) => e as String)
            .toList();
    if (entity != null) {
      return copiedTypes..add(entity);
    } else {
      return copiedTypes;
    }
  }

  /// Add data to the block
  Map<String, dynamic> addData(Map<String, dynamic> data) {
    Map<String, dynamic> copiedData =
        jsonDecode(jsonEncode(this.data)) as Map<String, dynamic>;
    return copiedData..addAll(data);
  }

  /// get block from plugins' rendering map
  /// If no match, then use default
  BaseBlock getBlock(BaseBlock block, List<BasePlugin> plugins) {
    for (var plugin in plugins) {
      for (var style in block.inlineStyles) {
        if (plugin.inlineStyleRenderFn?.containsKey(style) ?? false) {
          return plugin.inlineStyleRenderFn![style]!.copyWith(block: block);
        }
      }
      for (var entity in block.entityTypes) {
        if (plugin.entityRenderFn?.containsKey(entity) ?? false) {
          return plugin.entityRenderFn![entity]!.copyWith(block: block);
        }
      }
    }

    return block;
  }

  /// Apply inline styles or entity data to the block
  ///
  /// @param [start]: start of the block
  ///
  /// @param [end]: end of the block
  ///
  /// @param [style]: Inline style of the block
  ///
  /// @param [entity]: Entity type of the block
  ///
  /// @param [data]: data of the block
  ///
  /// @param [plugins]: List of plugins
  ///
  /// @param [depth]: depth of the block
  List<BaseBlock> split(
      {required int start,
      required int end,
      String? style,
      String? entity,
      required Map<String, dynamic> data,
      required List<BasePlugin> plugins,
      int? depth}) {
    List<BaseBlock> blocks = [];
    if (start <= this.start && end >= this.end) {
      blocks = [
        BaseBlock(
          depth: depth ?? this.depth,
          blockType: this.blockType,
          start: this.start,
          end: this.end,
          inlineStyles: this.addStyle(style),
          data: this.addData(data),
          entityTypes: this.addEntityType(entity),
          text: this.text,
        )
      ];
    } else if (start > this.start && end >= this.end) {
      var first = BaseBlock(
        depth: depth ?? this.depth,
        blockType: this.blockType,
        start: this.start,
        end: start,
        data: this.addData({}),
        inlineStyles: addStyle(null),
        entityTypes: this.addEntityType(null),
        text: this.text,
      );
      var middle = BaseBlock(
        depth: depth ?? this.depth,
        blockType: this.blockType,
        start: start,
        end: this.end,
        data: this.addData(data),
        inlineStyles: this.addStyle(style),
        entityTypes: this.addEntityType(entity),
        text: this.text,
      );

      blocks = [first, middle];
    } else if (start <= this.start && end < this.end) {
      var first = BaseBlock(
        depth: depth ?? this.depth,
        blockType: this.blockType,
        start: this.start,
        end: end,
        data: this.addData(data),
        inlineStyles: this.addStyle(style),
        entityTypes: this.addEntityType(entity),
        text: this.text,
      );

      var middle = BaseBlock(
        depth: depth ?? this.depth,
        blockType: this.blockType,
        start: end,
        end: this.end,
        data: this.addData({}),
        inlineStyles: this.addStyle(null),
        entityTypes: this.addEntityType(null),
        text: this.text,
      );

      blocks = [first, middle];
    } else if (start > this.start && end < this.end) {
      var first = BaseBlock(
        depth: depth ?? this.depth,
        blockType: this.blockType,
        start: this.start,
        end: start,
        data: this.addData({}),
        inlineStyles: this.addStyle(null),
        entityTypes: this.addEntityType(null),
        text: this.text,
      );

      var middle = BaseBlock(
        depth: depth ?? this.depth,
        blockType: this.blockType,
        start: start,
        end: end,
        data: this.addData(data),
        inlineStyles: this.addStyle(style),
        entityTypes: this.addEntityType(entity),
        text: this.text,
      );

      var last = BaseBlock(
        depth: depth ?? this.depth,
        blockType: this.blockType,
        start: end,
        end: this.end,
        data: this.addData({}),
        inlineStyles: this.addStyle(null),
        entityTypes: this.addEntityType(null),
        text: this.text,
      );

      blocks = [first, middle, last];
    }

    blocks = blocks.map((e) => this.getBlock(e, plugins)).toList();

    return blocks;
  }

  /// get text color
  Color textColor(context) {
    var color = Theme.of(context).textTheme.bodyText1!.color!;
    var style = inlineStyles.firstWhere((element) => element[0] == "#",
        orElse: () => "");
    if (style.isNotEmpty) {
      color = HexColor.fromHex(style);
    }

    return color;
  }

  /// Get fontweight for each block based on their [inline styles]
  FontWeight get fontWeight =>
      this.inlineStyles.contains("BOLD") ? FontWeight.bold : FontWeight.normal;

  /// Get fontstyle for each block based on their [inline styles]
  FontStyle get fontStyle => this.inlineStyles.contains("ITALIC")
      ? FontStyle.italic
      : FontStyle.normal;

  /// Get decoration for each block based on their [inline styles]
  TextDecoration get decoration {
    TextDecoration decoration = TextDecoration.none;
    if (inlineStyles.contains("UNDERLINE")) {
      decoration = TextDecoration.combine([decoration, TextDecoration.underline]);
    }
    if (inlineStyles.contains("STRIKETHROUGH")) {
      decoration = TextDecoration.combine([decoration, TextDecoration.lineThrough]);
    }
    return decoration;
  }

  /// Render style based on the block's type and inline styles
  TextStyle renderStyle(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.bodyText1!;

    return textStyle.copyWith(
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      color: textColor(context),
    );
  }

  /// Render the current block
  ///
  /// @param [children] List of children
  InlineSpan render(BuildContext context, {List<InlineSpan>? children}) {
    return TextSpan(
      text: this.textContent,
      style: renderStyle(context),
      children: children,
    );
  }
}
