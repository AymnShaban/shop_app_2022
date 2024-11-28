import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/lauout/home_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';

import 'package:shop_app/styles/themes.dart';
import 'modules/on_boarding/on_boarding_Screen.dart';
import 'modules/search/cubit/cubit.dart';
import 'shared/components/constentce.dart';
import 'shared/network/remote/dio_helper.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CasheHelper.init();
  var onBoarding = CasheHelper.getData(key: 'onBoarding') ?? false;
  token = CasheHelper.getData(key: 'token') ?? '';
  print(token);
  // if(onBoarding != null){
  //   // ignore: unnecessary_null_comparison
  //   if(token != null) {
  //     widget= const HomeLayoutScreen();
  //   }
  //   else {
  //     widget = LoginScreen();
  //   }
  // }
  // else {
  //   widget= const OnBoardingScreen();
  // }
  runApp(MyApp(onBoarding!));
}
class MyApp extends StatelessWidget {
  final bool onBoarding;
  const MyApp(this.onBoarding);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => AppCubit()
              ..getHomeData()
              ..getCategoryData()
              ..getFavoritesData()
              ..getUsersData()),
        BlocProvider(create: (BuildContext context) => SearchCubit())
      ],
      child: MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: onBoarding != null
            ? token != null
                ? const HomeLayoutScreen()
                : LoginScreen()
            : const OnBoardingScreen(),
      ),
    );
  }
}
