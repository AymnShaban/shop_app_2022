import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/modules/search/srearch_model.dart';
import 'package:shop_app/shared/components/constentce.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search({required String text}) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: PRODUCTS_SEARCH,
      data: {'text': text},
      token: token,
    ).then((value) {
      emit(SearchSuccessState());
      model = SearchModel.fromJson(value.data);
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
