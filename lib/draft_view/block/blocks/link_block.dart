import 'dart:io';

import 'package:draft_view/draft_view/block/action_block.dart';
import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../callbacks.dart';

class LinkBlock extends ActionBlock {
  LinkBlock({
    @required int depth,
    @required int start,
    @required int end,
    @required List<String> inlineStyles,
    @required Map<String, dynamic> data,
    @required String text,
    @required List<String> entityTypes,
    @required String blockType,
    @required List<BaseBlock> children,
    @required List<CupertinoContextMenuAction> actions,
    @required OnTap onTap,
    @required OnDoubleTap onDoubleTap,
    @required OnLongPress onLongPress,
  }) : super(
          depth: depth,
          start: start,
          end: end,
          inlineStyles: inlineStyles,
          data: data,
          text: text,
          entityTypes: entityTypes,
          blockType: blockType,
          children: children,
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          actions: actions,
        );

  LinkBlock copyWith({BaseBlock block}) => LinkBlock(
        depth: block?.depth ?? depth,
        start: block?.start ?? this.start,
        end: block?.end ?? this.end,
        inlineStyles: block?.inlineStyles ?? this.inlineStyles,
        entityTypes: block?.entityTypes ?? this.entityTypes,
        data: block?.data ?? this.data,
        text: block?.text ?? this.text,
        blockType: block?.blockType ?? this.blockType,
        children: block?.children ?? children ?? [],
        actions: actions,
        onTap: onTap,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
      );
  @override
  TextDecoration get decoration => TextDecoration.underline;

  @override
  Color textColor(context) {
    return Colors.blue;
  }

  @override
  InlineSpan render(BuildContext context, {List<InlineSpan> children}) {
    GestureRecognizer recognizer;

    if (data.containsKey('url')) {
      if (data['url'] is String) {
        recognizer = TapGestureRecognizer()
          ..onTap = () {
            if (onTap != null) {
              onTap(this);
            } else {
              showBottomSheet(
                context: context,
                builder: (c) => LinkCard(
                  link: data['url'],
                  title: "No title",
                  summary: "No summary",
                ),
              );
            }
          };
      } else {
        recognizer = TapGestureRecognizer()
          ..onTap = () {
            if (onTap != null) {
              onTap(this);
            } else {
              showBottomSheet(
                context: context,
                builder: (c) => LinkCard(
                  link: data['url']['link'],
                  title: data['url']['title'],
                  image: data['url']['image'],
                  summary: data['url']['summary'],
                ),
              );
            }
          };
      }
    }

    return TextSpan(
      recognizer: recognizer,
      text: "$textContent",
      children: children,
      style: renderStyle(context),
    );
  }
}

class LinkCard extends StatelessWidget {
  final String title;
  final String link;
  final String summary;
  final String image;

  const LinkCard({
    Key key,
    this.title,
    @required this.link,
    this.summary,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    leading: image != null
                        ? Image.network(
                            image,
                            height: 50,
                            width: 150,
                            fit: BoxFit.fitWidth,
                            loadingBuilder: (c, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                height: 50,
                                width: 150,
                                child: Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                              );
                            },
                          )
                        : null,
                    title: Text("${title ?? "No title"}"),
                    subtitle: Text("${summary ?? ""}"),
                    trailing: IconButton(
                      tooltip: "Open in browser",
                      icon: Icon(Icons.launch),
                      onPressed: () async {
                        if (await canLaunch(link)) {
                          await launch(link);
                        }
                      },
                    ),
                  )),
            ),
          ),
        ),
        Positioned(
          right: 5,
          child: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        )
      ],
    );
  }
}
