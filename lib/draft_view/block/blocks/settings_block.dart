import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter/material.dart';

// To parse this JSON data, do
//
//     final settings = settingsFromJson(jsonString);
//     final postSettings = postSettingsFromJson(jsonString);
//     final detailSettings = detailSettingsFromJson(jsonString);

import 'dart:convert';

Settings settingsFromJson(String str) => Settings.fromJson(json.decode(str));

String settingsToJson(Settings data) => json.encode(data.toJson());

_PostSettings postSettingsFromJson(String str) =>
    _PostSettings.fromJson(json.decode(str));

String postSettingsToJson(_PostSettings data) => json.encode(data.toJson());

_DetailSettings detailSettingsFromJson(String str) =>
    _DetailSettings.fromJson(json.decode(str));

String detailSettingsToJson(_DetailSettings data) => json.encode(data.toJson());

/// Post Settings object
class Settings {
  Settings({
    required this.settings,
  });

  List<_PostSettings> settings;

  Settings copyWith({
    List<_PostSettings>? settings,
  }) =>
      Settings(
        settings: settings ?? this.settings,
      );

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        settings: json["settings"] == null
            ? []
            : List<_PostSettings>.from(
                json["settings"].map(
                  (x) => _PostSettings.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "settings": settings == null
            ? null
            : List<dynamic>.from(settings.map((x) => x.toJson())),
      };
}

class _PostSettings {
  _PostSettings({
    required this.detailSettings,
    required this.id,
  });

  List<_DetailSettings> detailSettings;
  String id;

  _PostSettings copyWith({
    List<_DetailSettings>? detailSettings,
    String? id,
  }) =>
      _PostSettings(
        detailSettings: detailSettings ?? this.detailSettings,
        id: id ?? this.id,
      );

  factory _PostSettings.fromJson(Map<String, dynamic> json) => _PostSettings(
        detailSettings: json["detailSettings"] == null
            ? []
            : List<_DetailSettings>.from(
                json["detailSettings"].map((x) => _DetailSettings.fromJson(x))),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "detailSettings": detailSettings == null
            ? null
            : List<dynamic>.from(detailSettings.map((x) => x.toJson())),
        "id": id == null ? null : id,
      };
}

class _DetailSettings {
  _DetailSettings({
    required this.description,
    required this.name,
    required this.id,
  });

  String description;
  String name;
  String id;

  _DetailSettings copyWith({
    String? description,
    String? name,
    String? id,
  }) =>
      _DetailSettings(
        description: description ?? this.description,
        name: name ?? this.name,
        id: id ?? this.id,
      );

  factory _DetailSettings.fromJson(Map<String, dynamic> json) =>
      _DetailSettings(
          description: json["description"] == null ? null : json["description"],
          name: json["name"] == null ? null : json["name"],
          id: json['id']);

  Map<String, dynamic> toJson() => {
        "description": description == null ? null : description,
        "name": name == null ? null : name,
        "id": id,
      };
}

/// Post setting's block. This block will be used to render the keyword (like a hashtag ) in blog.
/// For example [iPhone] is a post setting's block
class PostSettingsBlock extends BaseBlock {
  final Settings settings;

  PostSettingsBlock({
    required int depth,
    required int start,
    required int end,
    required List<String> inlineStyles,
    required Map<String, dynamic> data,
    required String text,
    required List<String> entityTypes,
    required String blockType,
    required this.settings,
  }) : super(
          depth: depth,
          start: start,
          end: end,
          inlineStyles: inlineStyles,
          data: data,
          text: text,
          entityTypes: entityTypes,
          blockType: blockType,
        );

  PostSettingsBlock copyWith({BaseBlock? block}) => PostSettingsBlock(
        depth: block?.depth ?? this.depth,
        start: block?.start ?? this.start,
        end: block?.end ?? this.end,
        inlineStyles: block?.inlineStyles ?? this.inlineStyles,
        entityTypes: block?.entityTypes ?? this.entityTypes,
        data: block?.data ?? this.data,
        text: block?.text ?? this.text,
        blockType: block?.blockType ?? this.blockType,
        settings: this.settings,
      );

  @override
  InlineSpan render(BuildContext context, {List<InlineSpan>? children}) {
    late _DetailSettings _detailSettings;
    var textStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
          color: Colors.orange,
        );

    for (var setting in settings.settings) {
      for (var ds in setting.detailSettings) {
        if (ds.id == data['id']) {
          _detailSettings = ds;
        }
      }
    }

    return TextSpan(text: _detailSettings.name, style: textStyle, children: [
      WidgetSpan(
        style: textStyle,
        alignment: PlaceholderAlignment.middle,
        child: Tooltip(
          message: _detailSettings.description,
          child: InkWell(
            onHover: (_) {},
            onTap: () {},
            child: Icon(
              Icons.link,
              color: textStyle.color,
              size: 20,
            ),
          ),
        ),
      )
    ]);
  }
}
