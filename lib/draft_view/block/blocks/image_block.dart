import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter/material.dart';

class ImageBlock extends BaseBlock {


  ImageBlock({
    required int depth,
    required int start,
    required int end,
    required List<String> inlineStyles,
    required Map<String, dynamic> data,
    required String text,
    required List<String> entityTypes,
    required String blockType,
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

  ImageBlock copyWith({BaseBlock? block}) => ImageBlock(
        depth: block?.depth ?? this.depth,
        start: block?.start ?? this.start,
        end: block?.end ?? this.end,
        inlineStyles: block?.inlineStyles ?? this.inlineStyles,
        entityTypes: block?.entityTypes ?? this.entityTypes,
        data: block?.data ?? this.data,
        text: block?.text ?? this.text,
        blockType: block?.blockType ?? this.blockType,
      );

  @override
  InlineSpan render(BuildContext context, {List<InlineSpan>? children}) {
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
