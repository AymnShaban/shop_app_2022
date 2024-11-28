import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/styles/colors.dart';

import '../../shared/cubit/cubit.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is AppSuccessChangeFavoritesState){
          if(!state.model.status){
            showToast(text:state.model.message, color: Colors.red);
          }

        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.homeModel != null,
            builder: (context) =>
                productsBuilder(
                    cubit.homeModel, cubit.categoriesModel, context),
            fallback: (context) =>
            const Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget productsBuilder(HomeModel? model, CategoriesModel? categoriesModel,
      context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model?.data!.banners
                    .map(
                      (e) =>
                      Image(
                        image: NetworkImage(e.image!),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                )
                    .toList(),
                options: CarouselOptions(
                    height: 250,
                    autoPlay: true,
                    enableInfiniteScroll: true,
                    reverse: false,
                    scrollDirection: Axis.horizontal,
                    initialPage: 0,
                    viewportFraction: 1,
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayCurve: Curves.fastOutSlowIn)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 30, fontFamily: 'Qq'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            buildCategoryItem(
                              categoriesModel!.data!.data[index],),
                        separatorBuilder: (context, index) =>
                            const SizedBox(
                              width: 10,
                            ),
                        itemCount: categoriesModel!.data!.data.length),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'New Products',
                    style: TextStyle(fontSize: 30, fontFamily: 'Qq'),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[100],
              child: GridView.count(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10.3,
                childAspectRatio: 1 / 1.59,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(model!.data!.products.length,
                        (index) =>
                        buildGridProduct(model.data!.products[index], context)),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(ProductsModel model, context) =>
      Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image(
                        image: NetworkImage(model.image!),
                        width: double.infinity,
                        height: 200,
                      ),
                      if (model.discount != 0)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                              color: Colors.deepPurple,
                              child: const Text(
                                ' Discount ',
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                    ],
                  ),
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: const TextStyle(
                          color: defultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.old_price}',
                          style: TextStyle(
                            color: Colors.grey[700],
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            AppCubit.get(context).changeFavorites(model.id!);
                            print(model.id);
                          },
                          icon: AppCubit.get(context)
                              .favorites[model.id]! ? const Icon(
                            Icons.favorite, color: Colors.red,) :
                              const Icon(Icons.favorite_border)
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(DataModel model) =>
      Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            height: 100,
            width: 100,
            child: Image(
                image: NetworkImage(
                  model.image,
                )),
          ),
          Container(
            height: 20,
            width: 100,
            color: Colors.black.withOpacity(0.6),
            child: Center(
              child: Text(
                model.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      );
}
