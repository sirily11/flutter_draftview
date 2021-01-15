import 'package:draft_view/draft_view/block/base_block.dart';

abstract class BasePlugin {
  Map<String, BaseBlock>? get blockStyleFn;

  Map<String, BaseBlock>? get entityRenderFn;

  Map<String, BaseBlock>? get inlineStyleRenderFn;
}
