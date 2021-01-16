import 'package:draft_view/draft_view/block/blocks/header_block.dart';
import 'package:draft_view/draft_view/block/blocks/list_block.dart';
import 'package:draft_view/draft_view/block/blocks/text_block.dart';
import 'package:draft_view/draft_view/plugin/base_plugin.dart';

import '../../../draft_view.dart';

class ListPlugin extends BasePlugin {
  @override
  blockRenderFn(BaseBlock block) => {
        "ordered-list-item": ListBlock(
          depth: 0,
          blockType: '',
          data: {},
          end: 0,
          entityTypes: [],
          inlineStyles: [],
          start: 0,
          text: '',
          isOrderedList: true,
        ),
        "unordered-list-item": ListBlock(
          depth: 0,
          blockType: '',
          data: {},
          end: 0,
          entityTypes: [],
          inlineStyles: [],
          start: 0,
          text: '',
          isOrderedList: false,
        ),
      };
}

class ListTreeNode {
  final ListTreeNode? parent;
  final ListBlock? content;
  final List<ListTreeNode> children = [];
  final bool isRoot;

  ListTreeNode({
    this.parent,
    this.content,
    required this.isRoot,
  });

  ListTreeNode addChild(ListBlock listBlock) {
    var treeNode =
        ListTreeNode(isRoot: false, parent: this, content: listBlock);
    this.children.add(treeNode);
    return treeNode;
  }

  int get depth {
    int dep = 0;
    var parent = this.parent;
    while (parent != null) {
      parent = parent.parent;
      dep += 1;
    }

    return dep;
  }

  int get order {
    if (this.parent != null) {
      int i = 1;
      for (var child in this.parent!.children) {
        if (child == this) {
          return i;
        }
        i += 1;
      }
    }

    return 0;
  }
}
