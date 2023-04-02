import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'myAppBar.dart';

class PodPlay extends StatefulWidget {
  const PodPlay({Key? key,required this.podTitle, required this.podDate, required this.podUrl, required this.imgUrl}) : super(key: key);

  final String podTitle;
  final String podDate;
  final String podUrl;
  final String imgUrl;

  @override
  _PodPlayState createState() => _PodPlayState();
}

class _PodPlayState extends State<PodPlay> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(': ');
  }

  @override
  void initState() {
    super.initState();
    
    setAudio();
    
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }
  
  Future setAudio() async {
    audioPlayer.setSourceUrl(widget.podUrl);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(appBar: AppBar(), color: Colors.white),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 3.h),
                    child: Center(
                      child: SizedBox(
                        height: 30.h,
                        width: 30.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.imgUrl,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 2.h),
                    child: Text(
                      widget.podTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 19.sp),
                    ),
                  ),
                  Center(
                    child: Text(
                      widget.podDate,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: const Color(0xffA3A3A3)
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3.h),
                    child: Slider(
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds.toDouble(),
                      activeColor: const Color(0xff1e73be),
                      onChanged: (value) async {
                        final position = Duration(seconds: value.toInt());
                        await audioPlayer.seek(position);

                        await audioPlayer.resume();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatTime(position),
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: const Color(0xffA3A3A3)
                          ),
                        ),
                        Text(
                          formatTime(duration - position),
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: const Color(0xffA3A3A3)
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3.h),
                    child: Center(
                      child: CircleAvatar(
                        radius: 35,
                        child: IconButton(
                          icon: Icon(
                            isPlaying ? Icons.pause_outlined : Icons.play_arrow_outlined,
                          ),
                          iconSize: 50,
                          onPressed: () async {
                            if (isPlaying) {
                              await audioPlayer.pause();
                            } else {
                              await audioPlayer.resume();
                            }
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}