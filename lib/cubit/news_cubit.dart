import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/buisness_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';

import '../modules/settings/settings_screen.dart';
import '../network/dio_helper.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  int currentIndexNavBar = 0 ;
  List<BottomNavigationBarItem> bottomNavBarItems= const [
    BottomNavigationBarItem(
      icon: Icon(Icons.business_center) ,
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports) ,
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science) ,
      label: 'Science',
    ),

  ];
  List<Widget> Screens = const [
    BusinessScreen(),
    SportsScreen() ,
    ScienceScreen(),
  ];
  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  NewsCubit() : super(NewsInitial());
  static NewsCubit get(context) => BlocProvider.of(context);

  void changeBottomNavBar(int index){
    currentIndexNavBar = index ;
    if(index == 1) getSports();
    if(index == 2) getScience();
    emit(NewsBottomNavState());
  }

    void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '601268630c9b4bfab7f3652509beeb0e',
    }).then((value){
      business =value.data['articles'] ;
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((onError) {
      print('${onError.toString()} * * * * ');
      emit(NewsGetBusinessErrorState(onError.toString()));
    });
  }

    void getSports(){
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': '601268630c9b4bfab7f3652509beeb0e',
    }).then((value){
      sports =value.data['articles'] ;
      print(sports[0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((onError) {
      print('${onError.toString()} * * * * ');
      emit(NewsGetSportsErrorState(onError.toString()));
    });
  }

    void getScience(){
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': '601268630c9b4bfab7f3652509beeb0e',
    }).then((value){
      science =value.data['articles'] ;
      print(science[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((onError) {
      print('${onError.toString()} * * * * ');
      emit(NewsGetScienceErrorState(onError.toString()));
    });
  }


    void getSearch({required String value}){
    emit(NewsGetSearchLoadingState());
    search = [] ;
    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': '601268630c9b4bfab7f3652509beeb0e',
    }).then((value){
      search =value.data['articles'] ;
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((onError) {
      print('${onError.toString()} * * * * ');
      emit(NewsGetSearchErrorState(onError.toString()));
    });
  }


}
