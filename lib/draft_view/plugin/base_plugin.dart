import 'package:draft_view/draft_view/block/base_block.dart';

abstract class BasePlugin {
  /// Block renderer map
  Map<String, BaseBlock>? blockRenderFn(BaseBlock block,
          {bool shouldWrite = false}) =>
      null;

  /// Entity type renderer map
  Map<String, BaseBlock>? get entityRenderFn => null;

  Map<String, BaseBlock>? get inlineStyleRenderFn => null;
}
