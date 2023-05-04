import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //화면을 항상 세로로 고정
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  //화면상단 부분의 스타일 설정인데 전체를 지정할수도 있지만 화면마다 지정해주는게 좋겠다
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TikTok Clone',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        textTheme: Typography.blackCupertino,
        brightness: Brightness.light,
        //모든 스캐폴드 배경 화이트
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFE9435A),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        splashColor: const Color(0xFFE9435A),
        highlightColor: Colors.amberAccent,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size18,
            fontWeight: FontWeight.w600,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.red,
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey.shade500,
          indicatorColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        textTheme: Typography.whiteCupertino,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFE9435A),
      ),
      initialRoute: "/",
      routes: {
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        UsernameScreen.routeName: (context) => const UsernameScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        EmailScreen.routeName: (context) => const EmailScreen(),
      },
    );
  }
}
