import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/features/users/user_profile_screen.dart';
import 'package:tiktok_clone/features/videos/inbox/inbox_screen.dart';
import 'package:tiktok_clone/features/videos/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  static String routeName = "mainNavigation";

  final String tab;

  const MainNavigationScreen({super.key, required this.tab});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    "home",
    "discover",
    "xxxx",
    "inbox",
    "profile",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  final screens = [
    const Center(
      child: Text('Home'),
    ),
    const Center(
      child: Text('Discover'),
    ),
    Container(),
    const Center(
      child: Text('Inbox'),
    ),
    const Center(
      child: Text('Profile'),
    ),
  ];

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Record video'),
          ),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: _selectedIndex == 0 ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTap(
                text: 'Home',
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndex,
              ),
              NavTap(
                text: 'Discover',
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                onTap: () => _onTap(1),
                selectedIndex: _selectedIndex,
              ),
              Gaps.h24,
              GestureDetector(
                onTap: _onPostVideoButtonTap,
                child: PostVideoButton(
                  inverted: _selectedIndex != 0,
                ),
              ),
              Gaps.h24,
              NavTap(
                text: 'Inbox',
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                onTap: () => _onTap(3),
                selectedIndex: _selectedIndex,
              ),
              NavTap(
                text: 'Profile',
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                onTap: () => _onTap(4),
                selectedIndex: _selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );

    // Cupertino Style
    // return CupertinoTabScaffold(
    //   tabBar: CupertinoTabBar(
    //     items: const [
    //       BottomNavigationBarItem(
    //         icon: Icon(CupertinoIcons.house),
    //         label: "Home",
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(CupertinoIcons.search),
    //       ),
    //     ],
    //   ),
    //   tabBuilder: (context, index) => screens[index],
    // );

    // Material Style
    // Scaffold(
    //   body: screens[_selectedIndex],
    //   bottomNavigationBar: NavigationBar(
    //     // 선택된것만 보여줌
    //     labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    //     destinations: const [
    //       NavigationDestination(
    //         icon: FaIcon(
    //           FontAwesomeIcons.house,
    //           color: Colors.teal,
    //         ),
    //         label: 'Home',
    //       ),
    //       NavigationDestination(
    //         icon: FaIcon(
    //           FontAwesomeIcons.magnifyingGlass,
    //           color: Colors.amber,
    //         ),
    //         label: 'Search',
    //       ),
    //       NavigationDestination(
    //         icon: FaIcon(
    //           FontAwesomeIcons.laptop,
    //           color: Colors.blue,
    //         ),
    //         label: 'Search',
    //       ),
    //       NavigationDestination(
    //         icon: FaIcon(
    //           FontAwesomeIcons.instagram,
    //           color: Colors.purple,
    //         ),
    //         label: 'Search',
    //       ),
    //       NavigationDestination(
    //         icon: FaIcon(
    //           FontAwesomeIcons.info,
    //           color: Colors.green,
    //         ),
    //         label: 'Search',
    //       ),
    //     ],
    //     selectedIndex: _selectedIndex,
    //     onDestinationSelected: _onTap,
    //   ),
    // );
  }
}
