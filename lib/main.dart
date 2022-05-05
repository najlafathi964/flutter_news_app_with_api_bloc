import 'package:dio/src/response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app_api/cubit/app_cubit.dart';
import 'package:news_app_api/cubit/app_state.dart';
import 'package:news_app_api/shared/network/remote/dio_helper.dart';
import 'package:news_app_api/shared/network/local/cach_helper.dart';

import 'bloc_observer.dart';
import 'layouts/news_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(() {}, blocObserver: SimpleBlocObserver());
  dioHelper.init();
  await cachHelper.init();
  bool? isDark = cachHelper.getData(key: 'isDark');
  print("dark is $isDark");
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => NewsCubit()..getBusiness()),
      BlocProvider(
          create: (context) => NewsCubit()..changeAppMode(dark: isDark))
    ],
    child: BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) => MaterialApp(
        home: Directionality(
            textDirection: TextDirection.rtl, child: news_home()),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            iconTheme: IconThemeData(color: Colors.deepOrange),
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                elevation: 0,
                titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark)),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                backgroundColor: Colors.white,
                elevation: 20),
            textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black)),
            scaffoldBackgroundColor: Colors.white),
        darkTheme: ThemeData(
          primarySwatch: Colors.deepOrange,
          appBarTheme: AppBarTheme(
              backgroundColor: HexColor('333739'),
              elevation: 0,
              titleSpacing: 20,
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20),
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: HexColor('333739'),
                statusBarIconBrightness: Brightness.light,
              )),
          iconTheme: IconThemeData(color: Colors.white),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: HexColor('333739'),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              elevation: 20),
          textTheme: TextTheme(
              bodyText1: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white)),
          scaffoldBackgroundColor: HexColor('333739'),
        ),
        themeMode:
            NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
      ),
    ),
  ));
}
