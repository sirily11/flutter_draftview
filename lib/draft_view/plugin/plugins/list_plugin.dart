import '../../../draft_view.dart';

class ListPlugin extends BasePlugin {
  ListTreeNode root = ListTreeNode(isRoot: true);
  ListTreeNode? prevNode;
  ListTreeNode? currentLevel;

  @override
  blockRenderFn(BaseBlock block, {bool shouldWrite = false}) {
    if (currentLevel == null) {
      currentLevel = root;
    }

    if (shouldWrite) {
      if (block.blockType == "ordered-list-item") {
        if (block.depth == prevNode?.depth || prevNode == null) {
          prevNode = currentLevel!.addChild(block);
        } else {
          if (block.depth > prevNode!.depth) {
            currentLevel = prevNode;
            prevNode = prevNode!.addChild(block);
          } else {
            currentLevel = currentLevel!.parent;
            prevNode = currentLevel!.addChild(block);
          }
        }
      } else {
        root = ListTreeNode(isRoot: true);
        prevNode = null;
        currentLevel = root;
      }
    }

    var map = {
      "ordered-list-item": ListBlock(
        depth: prevNode?.depth ?? 0,
        blockType: '',
        data: {},
        end: 0,
        entityTypes: [],
        inlineStyles: [],
        start: 0,
        text: '',
        isOrderedList: true,
        order: prevNode?.order ?? 0,
      ),
      "unordered-list-item": ListBlock(
        depth: block.depth,
        blockType: '',
        data: {},
        end: 0,
        entityTypes: [],
        inlineStyles: [],
        start: 0,
        text: '',
        isOrderedList: false,
        order: 0,
      ),
    };

    return map;
  }
}

class ListTreeNode {
  final ListTreeNode? parent;
  final BaseBlock? content;
  final List<ListTreeNode> children = [];
  final bool isRoot;

  ListTreeNode({
    this.parent,
    this.content,
    required this.isRoot,
  });

  /// Add child to the current node. Return the newly created node
  ListTreeNode addChild(BaseBlock listBlock) {
    var treeNode =
        ListTreeNode(isRoot: false, parent: this, content: listBlock);
    this.children.add(treeNode);
    return treeNode;
  }

  int get depth {
    int dep = -1;
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
