import 'package:draft_view/draft_view/block/blocks/image_block.dart';
import 'package:draft_view/draft_view/plugin/base_plugin.dart';

class ImagePlugin extends BasePlugin {
  @override
  get entityRenderFn => {
        "image": ImageBlock(
          depth: 0,
          blockType: '',
          data: {},
          end: 0,
          entityTypes: [],
          inlineStyles: [],
          start: 0,
          text: '',
        )
      };
}
