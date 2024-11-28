import 'package:shop_app/models/userModel/login_model.dart';
import '../../models/change_favorites_model/chnage_favorites_model.dart';

abstract class AppStates {}


class AppLoginInitialState extends AppStates{}
class AppLoginLoadingState extends AppStates{}
class AppLoginSuccessState extends AppStates{
  final LoginModel loginModel;

  AppLoginSuccessState(this.loginModel);
}
class AppLoginErrorState extends AppStates{
  final String error;

  AppLoginErrorState(this.error);
}
class AppLoginChangeVisibilityState extends AppStates{}


class AppChangeBottomNavState extends AppStates{}


class AppLoadingHomeDataState extends AppStates{}
class AppSuccessHomeDataState extends AppStates{}
class AppErrorHomeDataState extends AppStates{}

class AppSuccessCategoryState extends AppStates{}
class AppErrorCategoryState extends AppStates{}

class AppSuccessChangeFavoritesState extends AppStates{
  final ChangeFavoritesModel model;
  AppSuccessChangeFavoritesState(this.model);
}
class AppErrorChangeFavoritesState extends AppStates{}

class AppSuccessGetFavState extends AppStates{}
class AppLoadingGetFavState extends AppStates{}
class AppErrorGetFavState extends AppStates{}

class AppSuccessGetUserDataState extends AppStates{}
class AppLoadingGetUserDataState extends AppStates{}
class AppErrorGetUserDataState extends AppStates{}

class AppRegisterLoadingState extends AppStates{}
class AppRegisterSuccessState extends AppStates{
  final LoginModel registerModel;

  AppRegisterSuccessState(this.registerModel);
}
class AppRegisterErrorState extends AppStates{
  final String error;

  AppRegisterErrorState(this.error);
}
class AppRegisterChangeVisibilityState extends AppStates{}

class AppUpDateLoadingState extends AppStates{}
class AppUpDateSuccessState extends AppStates{
  final LoginModel usermodel;

  AppUpDateSuccessState(this.usermodel);
}
class AppUpDateErrorState extends AppStates{
  final String error;

  AppUpDateErrorState(this.error);
}

