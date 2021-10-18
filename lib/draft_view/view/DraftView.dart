import 'package:collection/collection.dart';
import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:draft_view/draft_view/converter/converter.dart';
import 'package:draft_view/draft_view/plugin/base_plugin.dart';
import 'package:flutter/material.dart';

class DraftView extends StatefulWidget {
  final Map<String, dynamic> rawDraftData;
  final List<BasePlugin> plugins;

  const DraftView({Key? key, required this.rawDraftData, required this.plugins})
      : super(key: key);

  @override
  _DraftViewState createState() => _DraftViewState();
}

class _DraftViewState extends State<DraftView> {
  List<BaseBlock> blocks = [];

  @override
  void initState() {
    super.initState();
    blocks = _convertToBlocks();
    print(blocks);
  }

  @override
  void didUpdateWidget(DraftView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.plugins != widget.plugins ||
        oldWidget.rawDraftData != widget.rawDraftData) {
      setState(() {
        blocks = _convertToBlocks();
      });
    }
  }

  List<BaseBlock> _convertToBlocks() {
    var converter =
        Converter(plugins: widget.plugins, draftData: widget.rawDraftData);
    return converter.convert();
  }

  List<InlineSpan> _renderText() {
    List<InlineSpan> spans = [];
    int i = 0;

    while (i < blocks.length) {
      var curBlock = blocks[i];

      var span = curBlock.render(
        context,
        children: curBlock.children?.map((e) => e.render(context)).toList(),
      );
      spans.add(span);

      i++;
    }
    return spans;
  }

  TextAlign _textAlign() {
    final alignment = blocks.firstOrNull?.data['textAlignment'];
    switch (alignment) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.end;
    }
    return TextAlign.start;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _renderText(),
      ),
      textAlign: _textAlign(),
    );
  }
}
