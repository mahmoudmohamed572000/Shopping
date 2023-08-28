import 'package:flutter/material.dart';
import 'package:shop/layout/home_layout.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:shop/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/styles/themes.dart';
import 'package:shop/shared/components/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  Widget homeScreen;
  if (onBoarding != null) {
    if (token != null) {
      homeScreen = const HomeLayout();
    } else {
      homeScreen = const LoginScreen();
    }
  } else {
    homeScreen = const OnBoardingScreen();
  }
  runApp(MyApp(homeScreen: homeScreen));
}

class MyApp extends StatelessWidget {
  final Widget homeScreen;

  const MyApp({required this.homeScreen, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: homeScreen,
    );
  }
}
