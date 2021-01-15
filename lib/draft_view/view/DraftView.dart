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
      var prevBlock = i > 1 ? blocks[i - 1] : null;
      var nextBlock = i < blocks.length - 1 ? blocks[i + 1] : null;

      var span = curBlock.render(context);
      spans.add(span);

      if (curBlock.text.length > 0 && (nextBlock?.text.length ?? 0) > 0) {
        spans.add(TextSpan(text: '\n'));
        spans.add(TextSpan(text: '\n'));
      } else if (curBlock.text.length > 0 &&
          (prevBlock?.text.length ?? 0) > 0) {
        spans.add(TextSpan(text: '\n'));
        spans.add(TextSpan(text: '\n'));
      }
      i++;
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      showTrackOnHover: true,
      child: SingleChildScrollView(
        child: RichText(
          text: TextSpan(
            children: _renderText(),
          ),
        ),
      ),
    );
  }
}
