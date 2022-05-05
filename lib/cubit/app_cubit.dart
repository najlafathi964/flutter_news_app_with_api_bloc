import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api/cubit/app_state.dart';
import 'package:news_app_api/modules/business_screen.dart';
import 'package:news_app_api/modules/science_screen.dart';
import 'package:news_app_api/shared/network/local/cach_helper.dart';
import 'package:news_app_api/modules/sport_screen.dart';
import 'package:news_app_api/shared/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: "Business" ),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Sport" ),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science" ),

  ];
  List<Widget> screens = [businessScreen() , sportScreen() , scienceScreen() ] ;

  void changeBottomNavBar ( int index){
    currentIndex = index ;
    if(index == 0) getBusiness();
    if(index == 1 ) getSport() ;
    if(index == 2) getScience() ;
    emit(NewsBottomNavState()) ;
  }

  List<dynamic> business = [] ;
  void getBusiness (){
    emit(NewsGetBusinessLoadingState());
      dioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category': 'business',
            'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
          }).then((value) {
        // print(value.data.toString());
        business = value.data['articles'];
        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        emit(NewsGetBusinessErrorState(error.toString()));
        print(error.toString());
      });

  }

  List<dynamic> sports = [] ;
  void getSport (){
    emit(NewsGetSportLoadingState());
    if(sports.length == 0 ){
      dioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apiKey':'65f7f556ec76449fa7dc7c0069f040ca'

          }).then((value) {
        // print(value.data.toString());
        sports = value.data['articles'];
        emit(NewsGetSportSuccessState());
      }).catchError((error){
        emit(NewsGetSportErrorState(error.toString() ));
        print(error.toString());
      });
    }else {
      emit(NewsGetSportSuccessState());

    }
  }

  List<dynamic> science = [] ;
  void getScience (){
    emit(NewsGetScienceLoadingState());
    if(science.length == 0){
      dioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apiKey':'65f7f556ec76449fa7dc7c0069f040ca'

          }).then((value) {
        // print(value.data.toString());
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        emit(NewsGetScienceErrorState(error.toString() ));
        print(error.toString());
      });
    }else {
      emit(NewsGetScienceSuccessState());

    }
  }

  List<dynamic> search = [] ;
  void getSearch (String value){
    emit(NewsGetSearchLoadingState());
    search = [] ;
      dioHelper.getData(
          url: 'v2/everything',
          query: {
            'q':'$value',
            'apiKey':'65f7f556ec76449fa7dc7c0069f040ca'

          }).then((value) {
        // print(value.data.toString());
        search = value.data['articles'];
        emit(NewsGetSearchSuccessState());
      }).catchError((error){
        emit(NewsGetSearchErrorState(error.toString() ));
        print(error.toString());
      });

  }

  bool isDark = false ;

  void changeAppMode ({bool? dark }){
    if(dark != null) {
      isDark = dark;
      emit(NewsChangeModeState());
    }else {
      isDark = !isDark;
      cachHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangeModeState());

      });

    }

  }

}
