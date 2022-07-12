import 'package:draft_view/draft_view/block/blocks/link_block.dart';
import 'package:draft_view/draft_view/plugin/base_plugin.dart';

class LinkPlugin extends BasePlugin {
  @override
  get entityRenderFn => {
        "LINK": LinkBlock(
          depth: 0,
          blockType: '',
          data: {},
          end: 0,
          entityTypes: [],
          inlineStyles: [],
          start: 0,
          text: '',
          children: [],
        )
      };
}
