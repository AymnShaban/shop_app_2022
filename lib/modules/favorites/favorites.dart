import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model/favorites_model.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              itemBuilder: (context, index) => buildListProduct(
                  AppCubit.get(context)
                      .favoritesModel!
                      .data!
                      .data![index]
                      .product,
                  context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount:
                  AppCubit.get(context).favoritesModel!.data!.data!.length);
        });
  }
}
