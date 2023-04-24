import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  bool _isWriting = false;

  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  _stopWriting() {
    FocusScope.of(context).unfocus();
    _isWriting = false;
    setState(() {});
  }

  _onStartWriting() {
    _isWriting = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    return Container(
      height: size * 1.3,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size14,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: const Text("22796 comments"),
          actions: [
            IconButton(
              onPressed: _onClosePressed,
              icon: const FaIcon(
                FontAwesomeIcons.xmark,
              ),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: _stopWriting,
          child: Stack(
            children: [
              Scrollbar(
                child: ListView.separated(
                  padding: const EdgeInsets.only(
                    top: Sizes.size10,
                    bottom: Sizes.size72,
                    right: Sizes.size14,
                    left: Sizes.size14,
                  ),
                  separatorBuilder: (context, Index) => Gaps.v20,
                  itemCount: 10,
                  itemBuilder: (context, index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        child: Text('현석'),
                      ),
                      Gaps.h10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '현석',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.size14,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Gaps.v3,
                            const Text(
                              'There is no way go back..',
                            ),
                          ],
                        ),
                      ),
                      Gaps.h10,
                      Column(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size24,
                          ),
                          Gaps.v2,
                          Text(
                            '33K',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                //전자기종에 따라 높이가 달라서 MediaQuery로 코딩
                width: size,
                bottom: 0,
                child: BottomAppBar(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Sizes.size16,
                      right: Sizes.size16,
                      bottom: Sizes.size10,
                      top: Sizes.size8,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey.shade500,
                          foregroundImage: const NetworkImage(
                            "https://lh3.googleusercontent.com/ogw/AOLn63HrV89chfbY3H7hhjCbYhKyEU5_7xdS7B1H4bS4RQ=s32-c-mo",
                          ),
                          child: const Text('현석'),
                        ),
                        Gaps.h10,
                        Expanded(
                          child: SizedBox(
                            height: Sizes.size44,
                            child: TextField(
                              onTap: _onStartWriting,
                              expands: true,
                              minLines: null,
                              maxLines: null,
                              textInputAction: TextInputAction.newline,
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                hintText: "Write Comment",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(Sizes.size12),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: Sizes.size12,
                                  horizontal: Sizes.size10,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      right: Sizes.size14),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.at,
                                        color: Colors.grey.shade900,
                                      ),
                                      Gaps.h14,
                                      FaIcon(
                                        FontAwesomeIcons.gift,
                                        color: Colors.grey.shade900,
                                      ),
                                      Gaps.h14,
                                      FaIcon(
                                        FontAwesomeIcons.faceSmile,
                                        color: Colors.grey.shade900,
                                      ),
                                      Gaps.h14,
                                      if (_isWriting)
                                        GestureDetector(
                                          onTap: _stopWriting,
                                          child: FaIcon(
                                            FontAwesomeIcons.circleArrowUp,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
