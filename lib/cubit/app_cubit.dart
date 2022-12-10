import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/network/shared_preferences_helper.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  bool isDark = false;

  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  void changeAppMode() {
    isDark = !isDark;
    SharedPreferencesHelper.putDataBool(key: 'isDark', value: isDark).then((value) {
     emit(AppChangeModeState());
    });

  }
}
