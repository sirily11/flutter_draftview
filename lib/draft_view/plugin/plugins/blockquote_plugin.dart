import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:draft_view/draft_view/block/blocks/blockquote_block.dart';
import 'package:draft_view/draft_view/plugin/base_plugin.dart';

class BlockQuotePlugin extends BasePlugin {
  @override
  blockRenderFn(BaseBlock block, {bool shouldWrite = false}) => {
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
