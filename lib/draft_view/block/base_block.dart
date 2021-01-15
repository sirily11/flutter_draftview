import 'dart:convert';
import 'package:draft_view/draft_view/plugin/base_plugin.dart';
import 'package:flutter/material.dart';

class BaseBlock {
  final int start;
  final int end;
  final String text;
  final List<String> styles;
  final List<String> entityTypes;
  final Map<String, dynamic> data;

  BaseBlock({
    required this.start,
    required this.end,
    required this.styles,
    required this.data,
    required this.text,
    required this.entityTypes,
  });

  BaseBlock copyWith({BaseBlock? block}) => BaseBlock(
        start: block?.start ?? this.start,
        end: block?.end ?? this.end,
        styles: block?.styles ?? this.styles,
        entityTypes: block?.entityTypes ?? this.entityTypes,
        data: block?.data ?? this.data,
        text: block?.text ?? this.text,
      );

  /// Get text content based on the start and end
  String get textContent {
    return text.substring(start, end);
  }

  /// Add inline style to the block
  List<String> addStyle(String? style) {
    var copiedStyles = (jsonDecode(jsonEncode(this.styles)) as List)
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
  BaseBlock getBlock(BaseBlock block, List<BasePlugin> plugins) {
    for (var plugin in plugins) {
      for (var style in block.styles) {
        if (plugin.blockStyleFn?.containsKey(style) ?? false) {
          return plugin.blockStyleFn![style]!.copyWith(block: block);
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
  List<BaseBlock> split(int start, int end, String? style, String? entity,
      final Map<String, dynamic> data, List<BasePlugin> plugins) {
    List<BaseBlock> blocks = [];
    if (start <= this.start && end >= this.end) {
      return [
        BaseBlock(
          start: this.start,
          end: this.end,
          styles: this.addStyle(style),
          data: this.addData(data),
          entityTypes: this.addEntityType(entity),
          text: this.text,
        )
      ];
    } else if (start > this.start && end >= this.end) {
      var first = BaseBlock(
        start: this.start,
        end: start,
        data: this.addData({}),
        styles: addStyle(null),
        entityTypes: this.addEntityType(null),
        text: this.text,
      );
      var middle = BaseBlock(
        start: start,
        end: this.end,
        data: this.addData(data),
        styles: this.addStyle(style),
        entityTypes: this.addEntityType(entity),
        text: this.text,
      );

      blocks = [first, middle];
    } else if (start <= this.start && end < this.end) {
      var first = BaseBlock(
        start: this.start,
        end: end,
        data: this.addData(data),
        styles: this.addStyle(style),
        entityTypes: this.addEntityType(entity),
        text: this.text,
      );

      var middle = BaseBlock(
        start: end,
        end: this.end,
        data: this.addData({}),
        styles: this.addStyle(null),
        entityTypes: this.addEntityType(null),
        text: this.text,
      );

      blocks = [first, middle];
    } else if (start > this.start && end < this.end) {
      var first = BaseBlock(
        start: this.start,
        end: start,
        data: this.addData({}),
        styles: this.addStyle(null),
        entityTypes: this.addEntityType(null),
        text: this.text,
      );

      var middle = BaseBlock(
        start: start,
        end: end,
        data: this.addData(data),
        styles: this.addStyle(style),
        entityTypes: this.addEntityType(entity),
        text: this.text,
      );

      var last = BaseBlock(
        start: end,
        end: this.end,
        data: this.addData({}),
        styles: this.addStyle(null),
        entityTypes: this.addEntityType(null),
        text: this.text,
      );

      blocks = [first, middle, last];
    }

    blocks = blocks.map((e) => this.getBlock(e, plugins)).toList();

    return blocks;
  }

  TextStyle renderStyle() {
    FontWeight fontWeight =
        this.styles.contains("BOLD") ? FontWeight.bold : FontWeight.normal;
    FontStyle fontStyle =
        this.styles.contains("ITALIC") ? FontStyle.italic : FontStyle.normal;
    return TextStyle(
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }

  TextSpan render() {
    return TextSpan(text: this.textContent, style: renderStyle());
  }
}
