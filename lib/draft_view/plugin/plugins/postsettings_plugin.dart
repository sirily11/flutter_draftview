import 'package:draft_view/draft_view/block/blocks/settings_block.dart';
import 'package:draft_view/draft_view/plugin/base_plugin.dart';

class PostSettingsPlugin extends BasePlugin {
  late final Settings settings;

  PostSettingsPlugin({required Map<String, dynamic> rawSettings}) {
    this.settings = Settings.fromJson(rawSettings);
  }

  @override
  get entityRenderFn => {
        "POST-SETTINGS": PostSettingsBlock(
          depth: 0,
          blockType: '',
          data: {},
          end: 0,
          entityTypes: [],
          inlineStyles: [],
          start: 0,
          text: '',
          settings: settings,
        )
      };
}
