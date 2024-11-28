import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/models/change_favorites_model/chnage_favorites_model.dart';
import 'package:shop_app/models/favorites_model/favorites_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/models/userModel/login_model.dart';
import 'package:shop_app/modules/categories/categories.dart';
import 'package:shop_app/modules/favorites/favorites.dart';
import 'package:shop_app/modules/products/products.dart';
import 'package:shop_app/modules/settings/settings.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../components/constentce.dart';
import '../network/end_points.dart';

class AppCubit extends Cubit<AppStates> {
  // ignore: non_constant_identifier_names
  AppCubit() : super(AppLoginInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

   LoginModel? loginModel;
  Future userLogin({
    required String email,
    required String password,
  }) {
    emit(AppLoginLoadingState());

    return DioHelper.postData(url: LOGIN,
        data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(AppLoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(
        AppLoginErrorState(error.toString()),
      );
    });
  }

   LoginModel? registerModel;
  Future registerLogin({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(AppRegisterLoadingState());

    return DioHelper.postData(
        url: REGISTER,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
        }).then((value) {
      registerModel = LoginModel.fromJson(value.data);
      print(registerModel);
      emit(AppRegisterSuccessState(registerModel!));
    }).catchError((error) {
      print(error.toString());
      emit(
        AppRegisterErrorState(error.toString()),
      );
    });
  }


  IconData suffix = Icons.visibility;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off_outlined;
    emit(AppLoginChangeVisibilityState());
  }

  var currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }


  HomeModel? homeModel;
  void getHomeData() {
    emit(AppLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id!: element.in_favorites!});
      });
      emit(AppSuccessHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoryData() {
    DioHelper.getData(
      url: GET_GATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(AppSuccessCategoryState());
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorCategoryState());
    });
  }

  Map<int, bool> favorites = {};
  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId) {
    DioHelper.postData(
        url: FAVORITES,
        token: token,
        data: {'product_id': productId}).then((value) {
      favorites[productId] = !favorites[productId]!;

      changeFavoritesModel = ChangeFavoritesModel.fomJson(value.data);
      if(!changeFavoritesModel!.status){
        favorites[productId] = !favorites[productId]!;
      }else{
        getFavoritesData();
        emit(AppSuccessGetFavState());
      }
      emit(AppSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(AppErrorChangeFavoritesState());
    });



  }

  FavoritesModel? favoritesModel;
  void getFavoritesData() {
    emit(AppLoadingGetFavState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(AppSuccessGetFavState());
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorGetFavState());
    });
  }


  LoginModel? userModel;
  void getUsersData() {
    emit(AppLoadingGetUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(AppSuccessGetUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorGetUserDataState());
    });
  }

  void upDateUsersData({
  required String name,
  required String email,
  required String phone,
}) {
    emit(AppUpDateLoadingState());
    DioHelper.putData(
      data: {
        'name':name,
        'email':email,
        'password':phone
      },
      url: UPDATE_PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(AppUpDateSuccessState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(AppUpDateErrorState(error.toString()));
    });
  }


}
