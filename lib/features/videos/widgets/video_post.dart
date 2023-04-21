import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/widgets/video_button.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int index;
  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/pyramids.mp4");

  final hashtags = [
    '#egypt',
    '#pyramids',
    '#cairo',
    '#spinx',
    '#world',
    '#Travel',
    '#first'
  ];

  bool _isFullHashtag = false;

  bool _isPaused = false;

  final Duration _animationDuration = const Duration(milliseconds: 200);

  late final AnimationController _animationController;

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished;
      }
    }
  }

  void _seeMoreTap() {
    setState(() {
      _isFullHashtag = !_isFullHashtag;
    });
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    //비디오 재생 반복
    _videoPlayerController.setLooping(true);
    _videoPlayerController.play();
    setState(() {});
    _videoPlayerController.addListener(_onVideoChange);
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();

    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  //토글시 멈춤
  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: (info) {},
      child: Stack(
        children: [
          // 영상 재생
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.teal,
                  ),
          ),
          //클릭시 멈춤
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                // AnimatedBuilder 위젯은 AnimatedOpacity가 만들어진 child를 사용한다
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      //이부분에 AnimatedOpacity를 넣어도 무방하다
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "@dtseok",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Sizes.size20),
                ),
                Gaps.v10,
                const Text(
                  "This is my house in Egypt!!!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size16,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 300,
                      child: Text(
                        hashtags.join(' '),
                        maxLines: _isFullHashtag ? hashtags.length : 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ),
                    Gaps.h5,
                    GestureDetector(
                      onTap: _seeMoreTap,
                      child: Text(
                        _isFullHashtag ? "닫기" : "더 보기",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            right: 10,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundImage: const NetworkImage(
                    "https://lh3.googleusercontent.com/ogw/AOLn63HrV89chfbY3H7hhjCbYhKyEU5_7xdS7B1H4bS4RQ=s32-c-mo",
                  ),
                  child: const Text("현석"),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: "2.9M",
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.solidComment,
                  text: "33K",
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "Share",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
