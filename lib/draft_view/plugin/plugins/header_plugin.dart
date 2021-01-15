import 'package:draft_view/draft_view/block/blocks/header_block.dart';
import 'package:draft_view/draft_view/block/blocks/text_block.dart';
import 'package:draft_view/draft_view/plugin/base_plugin.dart';

class HeaderPlugin extends BasePlugin {
  @override
  get blockRenderFn => {
        "header-one": HeaderBlock(
          blockType: '',
          data: {},
          end: 0,
          entityTypes: [],
          inlineStyles: [],
          start: 0,
          text: '',
          level: 1,
        ),
        "header-two": HeaderBlock(
          blockType: '',
          data: {},
          end: 0,
          entityTypes: [],
          inlineStyles: [],
          start: 0,
          text: '',
          level: 2,
        ),
        "header-three": HeaderBlock(
          blockType: '',
          data: {},
          end: 0,
          entityTypes: [],
          inlineStyles: [],
          start: 0,
          text: '',
          level: 3,
        ),
        "header-four": HeaderBlock(
          blockType: '',
          data: {},
          end: 0,
          entityTypes: [],
          inlineStyles: [],
          start: 0,
          text: '',
          level: 4,
        ),
        "header-five": HeaderBlock(
          blockType: '',
          data: {},
          end: 0,
          entityTypes: [],
          inlineStyles: [],
          start: 0,
          text: '',
          level: 5,
        ),
        "header-six": HeaderBlock(
          blockType: '',
          data: {},
          end: 0,
          entityTypes: [],
          inlineStyles: [],
          start: 0,
          text: '',
          level: 6,
        ),
      };
}
