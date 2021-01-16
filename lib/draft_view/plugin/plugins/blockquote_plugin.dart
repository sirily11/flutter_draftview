import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:draft_view/draft_view/block/blocks/blockquote_block.dart';
import 'package:draft_view/draft_view/block/blocks/header_block.dart';
import 'package:draft_view/draft_view/block/blocks/text_block.dart';
import 'package:draft_view/draft_view/plugin/base_plugin.dart';

class BlockQuotePlugin extends BasePlugin {
  @override
  blockRenderFn(BaseBlock block) => {
        "blockquote": BlockQuoteBlock(
          depth: 0,
          blockType: '',
          data: {},
          end: 0,
          entityTypes: [],
          inlineStyles: [],
          start: 0,
          text: '',
          children: [],
        ),
      };
}
