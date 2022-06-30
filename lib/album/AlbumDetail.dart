import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:modul1/helper/model.dart';
import 'package:modul1/helper/transition.dart';

class AlbumDetail extends StatefulWidget {
  final onNext, index, artistName;
  final List<ArtistSongs> listOther;
  const AlbumDetail({Key? key, required this.onNext, required this.index, required this.listOther, required this.artistName}) : super(key: key);
  _Details createState() => _Details();
}

class _Details extends State<AlbumDetail> {
  initState() {
    setUpPlayer();
    _audioPlayer.playing;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              width: media.size.width,
              height: media.size.height,
              padding: EdgeInsets.fromLTRB(10, media.viewPadding.top, 10, 5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xff96979C), Color(0xff636669), Color(0xff25252D)],
                    stops: [0.2, 0.5, 0.8]
                ),
              ),
            ),

            Container(
              color: Colors.black.withOpacity(0.5),
            ),

            Positioned(
              top: 27.5,
              left: 5,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 30,
                  color: Colors.grey,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),

            Positioned(
              top: media.size.height * 0.15,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 4,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image(
                        image: NetworkImage(widget.listOther[widget.index].imageUrl),
                        fit: BoxFit.cover,
                        width: 225,
                        height: 225,
                      ),
                    ),
                  ),

                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: media.size.height * 0.005,
                          left: 20,
                          right: 20
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 5,
                            fit: FlexFit.tight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                  flex: 5,
                                  fit: FlexFit.tight,
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      widget.listOther[widget.index].title,
                                      style: TextStyle(
                                        color: Colors.grey[300],
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),

                                Flexible(
                                  flex: 5,
                                  fit: FlexFit.tight,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      widget.artistName,
                                      style: TextStyle(
                                        color: Colors.grey[300],
                                        letterSpacing: 1,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Flexible(
                            flex: 5,
                            fit: FlexFit.tight,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.grey[300],
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Flexible(
                    flex: 4,
                    fit: FlexFit.tight,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 7.5, 20, 5),
                              child: ValueListenableBuilder<DurationState>(
                                valueListenable: progressNotification,
                                builder: (x, value, z) {
                                  return ProgressBar(
                                    barHeight: 3,
                                    thumbRadius: 7.5,
                                    thumbColor: Colors.white,
                                    baseBarColor: Colors.grey[600],
                                    progressBarColor: Colors.grey[200],
                                    progress: value.current,
                                    total: value.total,
                                    onSeek: seekSong,
                                    timeLabelTextStyle: TextStyle(
                                      color: Colors.grey[300],
                                      fontSize: 15,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          Flexible(
                            flex: 7,
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.skip_previous),
                                      iconSize: 50,
                                      color: (widget.index > 0) ? Colors.grey[300] : Colors.grey,
                                      onPressed: (widget.index > 0)
                                          ? () {
                                        Navigator.of(context).pushReplacement(
                                            InstantTransitioned(
                                              page: AlbumDetail(
                                                onNext: widget.onNext,
                                                index: widget.index + 1,
                                                artistName: widget.artistName,
                                                listOther: widget.listOther,
                                              ),
                                            )
                                        );
                                      } : null,
                                    ),

                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        shape: BoxShape.circle,
                                      ),
                                      height: 75,
                                      width: 75,
                                      child: FittedBox(
                                        child: ValueListenableBuilder(
                                          valueListenable: buttonNotification,
                                          builder: (x, value, z) {
                                            switch (value) {
                                              case ButtonState.paused:
                                                return IconButton(
                                                  onPressed: () {
                                                    _audioPlayer.play();
                                                  },
                                                  icon: Icon(
                                                    Icons.play_arrow,
                                                    size: 30,
                                                    color: Colors.black,
                                                  ),
                                                );

                                              case ButtonState.playing:
                                                return IconButton(
                                                  onPressed: () {
                                                    _audioPlayer.pause();
                                                  },
                                                  icon: Icon(
                                                    Icons.pause,
                                                    size: 30,
                                                    color: Colors.black,
                                                  ),
                                                );

                                              default:
                                                return IconButton(
                                                  onPressed: () {
                                                    _audioPlayer.play();
                                                  },
                                                  icon: Icon(
                                                    Icons.play_arrow,
                                                    size: 30,
                                                    color: Colors.black,
                                                  ),
                                                );
                                            }
                                          },
                                        ),
                                      ),
                                    ),

                                    IconButton(
                                      icon: Icon(Icons.skip_next),
                                      iconSize: 50,
                                      color: (widget.index < widget.listOther.length -1) ? Colors.grey[300] : Colors.grey,
                                      onPressed: (widget.index < widget.listOther.length - 1)
                                          ? () {
                                        Navigator.of(context).pushReplacement(
                                            InstantTransitioned(
                                              page: AlbumDetail(
                                                onNext: widget.onNext,
                                                index: widget.index + 1,
                                                artistName: widget.artistName,
                                                listOther: widget.listOther,
                                              ),
                                            )
                                        );
                                      } : null,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }

  late var duration;
  final buttonNotification = ValueNotifier<ButtonState>(ButtonState.playing);
  AudioPlayer _audioPlayer = AudioPlayer();
  final progressNotification = ValueNotifier<DurationState>(
      DurationState(
        current: Duration.zero,
        buffered: Duration.zero,
        total: Duration.zero,
      )
  );

  setUpPlayer() async {
    duration = await _audioPlayer.setUrl(widget.listOther[widget.index].songsUrl);
    _audioPlayer.playerStateStream.listen((event) {
      final isPlaying = event.playing;
      final state = event.processingState;
      if (!isPlaying) {
        buttonNotification.value = ButtonState.paused;
      } else if (state != ProcessingState.completed) {
        buttonNotification.value = ButtonState.playing;
      } else {
        _audioPlayer.stop();
        if (widget.index < widget.listOther.length - 1) {
          Navigator.of(context).pushReplacement(
              InstantTransitioned(page: AlbumDetail(
                onNext: widget.onNext,
                index: widget.index + 1,
                artistName: widget.artistName,
                listOther: widget.listOther,
              ))
          );
        }
      }
    });

    _audioPlayer.positionStream.listen((newState) {
      final oldState = progressNotification.value;
      progressNotification.value = DurationState(
        current: newState,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });

    _audioPlayer.bufferedPositionStream.listen((newState) {
      final oldState = progressNotification.value;
      progressNotification.value = DurationState(
        current: oldState.current,
        buffered: newState,
        total: oldState.total,
      );
    });

    _audioPlayer.durationStream.listen((newState) {
      final oldState = progressNotification.value;
      progressNotification.value = DurationState(
        current: oldState,
        buffered: oldState.buffered,
        total: newState ?? Duration.zero,
      );
    });
  }

  dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  seekSong(Duration position) {
    _audioPlayer.seek(position);
  }
}

class DurationState {
  final current, buffered, total;
  const DurationState({required this.current, required this.buffered, required this.total});
}

enum ButtonState {
  paused, playing, stop
}