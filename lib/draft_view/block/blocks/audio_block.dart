import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

extension on Duration {
  String toAudioString() {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    if (inMicroseconds < 0) {
      return "-${-this}";
    }
    String twoDigitHours = twoDigits(inHours);
    String twoDigitMinutes = twoDigits(inMinutes.remainder(60) as int);
    String twoDigitSeconds = twoDigits(inSeconds.remainder(60) as int);

    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }
}

class AudioBlock extends BaseBlock {
  AudioBlock({
    required int depth,
    required int start,
    required int end,
    required List<String> inlineStyles,
    required Map<String, dynamic> data,
    required String text,
    required List<String> entityTypes,
    required String blockType,
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

  AudioBlock copyWith({BaseBlock? block}) => AudioBlock(
        depth: block?.depth ?? this.depth,
        start: block?.start ?? this.start,
        end: block?.end ?? this.end,
        inlineStyles: block?.inlineStyles ?? this.inlineStyles,
        entityTypes: block?.entityTypes ?? this.entityTypes,
        data: block?.data ?? this.data,
        text: block?.text ?? this.text,
        blockType: block?.blockType ?? this.blockType,
      );

  @override
  InlineSpan render(BuildContext context, {List<InlineSpan>? children}) {
    return WidgetSpan(
      child: AudioComponent(
        url: data['src'],
      ),
    );
  }
}

class AudioComponent extends StatefulWidget {
  final String url;

  AudioComponent({required this.url});

  @override
  _AudioComponentState createState() => _AudioComponentState();
}

class _AudioComponentState extends State<AudioComponent> {
  // final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool hasStarted = false;

  Future<void> _play() async {
    if (!hasStarted) {
      // await audioPlayer.play(widget.url);
      setState(() {
        isPlaying = true;
      });
    }
  }

  Future<void> _pauseOrResume() async {
    if (isPlaying) {
      // await audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      // await audioPlayer.resume();
      setState(() {
        isPlaying = true;
      });
    }
  }

  Future<void> _seekTo(Duration duration) async {
    // await audioPlayer.seek(duration);
  }

  Widget _buildPlayer(Duration total, Duration current) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: Column(
                children: [
                  Spacer(),
                  Text(
                      "Playback not support! ${current.toAudioString()} / ${total.toAudioString()}"),
                  Row(
                    children: [
                      Spacer(),
                      if (!isPlaying)
                        IconButton(
                          onPressed: () {
                            if (hasStarted) {
                              _pauseOrResume();
                            } else {
                              _play();
                            }
                          },
                          icon: Icon(Icons.play_arrow),
                        ),
                      if (isPlaying)
                        IconButton(
                          onPressed: () {
                            _pauseOrResume();
                          },
                          icon: Icon(Icons.pause),
                        ),
                      Spacer(),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: VerticalDivider(
                width: 10,
              ),
            ),
            Expanded(
              flex: 30,
              child: Column(
                children: [
                  Slider(
                    min: 0,
                    max: total.inMilliseconds.toDouble(),
                    value: current.inMilliseconds.toDouble(),
                    onChanged: (double value) async {
                      var duration = Duration(milliseconds: value.toInt());
                      await _seekTo(duration);
                    },
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Audio src: ",
                        style: Theme.of(context).textTheme.caption,
                        children: [
                          WidgetSpan(
                            child: InkWell(
                              onTap: () async {
                                if (await canLaunch(widget.url)) {
                                  await launch(widget.url);
                                }
                              },
                              child: Text(
                                "${widget.url}",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                              ),
                            ),
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildPlayer(
      Duration(seconds: 100),
      Duration(seconds: 0),
    );
  }
}
