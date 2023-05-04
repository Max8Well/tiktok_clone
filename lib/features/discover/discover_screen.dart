import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

final _tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _textEditingController =
      TextEditingController(text: "Initial Text");

  _onSearchChanged(String value) {
    print(value);
  }

  _onSearchSubmitted(String value) {
    print(value);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //width 변수를 주어 웹에서
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          //웹반응형 ConstrainedBox 를 통해서 입력필드가 무한대로 커지는것 방지
          title: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: Breakpoints.sm,
            ),
            child: CupertinoSearchTextField(
              controller: _textEditingController,
              onChanged: _onSearchChanged,
              onSubmitted: _onSearchSubmitted,
            ),
          ),
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            tabs: [
              for (var tab in _tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(
                Sizes.size6,
              ),
              itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //웹브라우저 크기별로 페이지 갯수 다르게 표시
                crossAxisCount: width > Breakpoints.lg ? 5 : 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 9 / 21,
              ),
              //웹브라우저 화면 조정때문에 LayoutBuilder 추가
              itemBuilder: (context, index) => LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Sizes.size4,
                        ),
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: 9 / 16,
                      child: Image.asset('assets/images/killbill1.jpeg'),
                      // child: FadeInImage.assetNetwork(
                      //   fit: BoxFit.cover,
                      //   placeholder: 'assets/images/killbill1.jpeg',
                      //   image:
                      //       'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2F20100928_50%2Fmahler_1285652989422formd_JPEG%2FKillBillVol11.jpg&type=sc960_832',
                      // ),
                    ),
                    Gaps.v10,
                    Text(
                      "${constraints.maxWidth} This is a very long caption for my tiktop that im upload just now currently",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v8,
                    if (constraints.maxWidth < 200 ||
                        constraints.maxWidth > 250)
                      DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                        child: const Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundImage: NetworkImage(
                                  'https://lh3.googleusercontent.com/ogw/AOLn63HrV89chfbY3H7hhjCbYhKyEU5_7xdS7B1H4bS4RQ=s32-c-mo'),
                            ),
                            Gaps.h4,
                            Expanded(
                              child: Text(
                                'My avatar is very long long',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Gaps.h4,
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size16,
                            ),
                            Gaps.h2,
                            Text(
                              '2.2M',
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
            for (var tab in _tabs.skip(1))
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(
                    fontSize: Sizes.size36,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
