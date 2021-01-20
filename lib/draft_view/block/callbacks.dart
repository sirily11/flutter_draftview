import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter/cupertino.dart';

typedef void OnTap(BaseBlock block);
typedef void OnDoubleTap(BaseBlock block);
typedef void OnLongPress(BaseBlock block);
typedef List<CupertinoContextMenuAction> ActionBuilder(BaseBlock block);