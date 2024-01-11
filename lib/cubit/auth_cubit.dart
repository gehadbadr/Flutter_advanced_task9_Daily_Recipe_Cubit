import 'package:bloc/bloc.dart';
import 'package:daily_recipe2/consts/consts.dart';
import 'package:daily_recipe2/models/user.models.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  bool isLoading = false;
  bool obscureText = false;
  final prefsFile = GetIt.I.get<SharedPreferences>();
  List<UserModel> userLists = [];
  bool _isTrue = true;
  bool _isConfirmPassword = true;
  bool get isTrue => _isTrue;
  bool get isConfirmPassword => _isConfirmPassword;

  AuthCubit() : super(AuthInitial());

  changeisLoading(bool value) {
    isLoading = value;
    emit(ChangeisLoading(isLoading));
  
  }

  get switchPasswordIcon {
    return _isConfirmPassword
        ? Icon(
            Icons.visibility_off,
            color: ColorsApp.PKColor,
          )
        : Icon(Icons.visibility);
  }

  get switchConfirmPasswordIcon {
    return _isTrue
        ? Icon(
            Icons.visibility_off,
            color: ColorsApp.PKColor,
          )
        : Icon(Icons.visibility);
  }

  void toggleConfirmPassword() {
      emit(ChangeisLoading(isLoading));
    _isConfirmPassword = !_isConfirmPassword;
  }

  void togglePassword() {
    emit(ChangeisLoading(isLoading));
    _isTrue = !_isTrue;
  }



  //SharedPrefrence

  Future savePrefs({email, password, name, login}) async {
    prefsFile.setString('name', name);
    prefsFile.setString('email', email);
    prefsFile.setString('password', password);
    prefsFile.setBool('login', login);
  }

  Future isLogin() async {
    bool? value = prefsFile.getBool('login');
    return value;
  }

  Future logOut() async {
    prefsFile.setBool('login', false);
  }

  Future getUesr() async {
    String? userValue = prefsFile.getString('name');
    String? emailValue = prefsFile.getString('email');
    String? passwordValue = prefsFile.getString('password');
    bool? loginValue = prefsFile.getBool('login');
    //List data =[userValue,emailValue,passwordValue,loginValue];
    Map<String, dynamic> info = {
      'user': userValue,
      'email': emailValue,
      'password': passwordValue,
      'login': loginValue,
    };
    return info;
  }

  //  Future<List<UserModel>> getUser1() async {

  //   String? userValue = prefsFile.getString('name');
  //   String? emailValue = prefsFile.getString('email');
  //   String? passwordValue = prefsFile.getString('password');
  //   bool? loginValue = prefsFile.getBool('login');
  //   //List data =[userValue,emailValue,passwordValue,loginValue];
  //     Map<String, dynamic> info = {
  //     'user': userValue,
  //     'email': emailValue,
  //     'password': passwordValue,
  //     'login': loginValue,
  //   };
  // userLists =info;
  // emit(AuthLoading());
  //   await Future.delayed(Duration(seconds: 3), () {
  //     emit(AuthLoaded(recipesLists,recommendedList));
  //   });
  //   // print(CarsoulState(adsLists:state.adsLists));
  // }
}
