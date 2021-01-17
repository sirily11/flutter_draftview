import 'package:draft_view/draft_view/block/blocks/audio_block.dart';
import 'package:draft_view/draft_view/plugin/base_plugin.dart';

class AudioPlugin extends BasePlugin {
  @override
  get entityRenderFn => {
        "audio": AudioBlock(
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