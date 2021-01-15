import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter/material.dart';

class ImageBlock extends BaseBlock {
  final int start;
  final int end;
  final String text;

  /// Block Type
  final String blockType;

  /// Inline styles
  final List<String> inlineStyles;

  /// Entity type
  final List<String> entityTypes;
  final Map<String, dynamic> data;

  ImageBlock({
    required this.start,
    required this.end,
    required this.inlineStyles,
    required this.data,
    required this.text,
    required this.entityTypes,
    required this.blockType,
  }) : super(
          start: start,
          end: end,
          inlineStyles: inlineStyles,
          data: data,
          text: text,
          entityTypes: entityTypes,
          blockType: blockType,
        );

  ImageBlock copyWith({BaseBlock? block}) => ImageBlock(
        start: block?.start ?? this.start,
        end: block?.end ?? this.end,
        inlineStyles: block?.inlineStyles ?? this.inlineStyles,
        entityTypes: block?.entityTypes ?? this.entityTypes,
        data: block?.data ?? this.data,
        text: block?.text ?? this.text,
        blockType: block?.blockType ?? this.blockType,
      );

  @override
  InlineSpan render(BuildContext context) {
    return WidgetSpan(
      child: ImageComponent(
        url: data['src'],
        caption: data['description'],
      ),
    );
  }
}

class ImageComponent extends StatelessWidget {
  final String url;
  final String caption;

  ImageComponent({required this.url, required this.caption});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          url,
          fit: BoxFit.fitWidth,
        ),
        Text(caption),
      ],
    );
  }
}
