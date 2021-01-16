import 'package:draft_view/draft_view/block/blocks/blockquote.dart';
import 'package:draft_view/draft_view/block/blocks/header_block.dart';
import 'package:draft_view/draft_view/block/blocks/text_block.dart';
import 'package:draft_view/draft_view/plugin/base_plugin.dart';

class BlockQuotePlugin extends BasePlugin {
  @override
  get blockRenderFn => {
        "blockquote": BlockQuoteBlock(
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
