import 'package:draft_view/draft_view/block/base_block.dart';

abstract class BasePlugin {
  Map<String, BaseBlock>? get blockRenderFn => null;

  Map<String, BaseBlock>? get entityRenderFn => null;

  Map<String, BaseBlock>? get inlineStyleRenderFn => null;
}
