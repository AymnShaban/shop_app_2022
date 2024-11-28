import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/styles/colors.dart';

import '../cubit/cubit.dart';

Widget defultTextFormField(
        {required TextEditingController controller,
        required TextInputType type,
        required String label,
        String? Function(String?)? validate,
        required IconData prefix,
        VoidCallback? suffixPressed,
        VoidCallback? ontap,
        Function(String)? onSubmit,
        Function(String)? onChange,
        IconData? suffix,
        bool isPassword = false}) =>
    TextFormField(
      onChanged: onChange,
      onTap: ontap,
      onFieldSubmitted: onSubmit,
      validator: validate,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        labelText: label,
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPressed,
              )
            : null,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        border: const OutlineInputBorder(),
      ),
    );

Widget defultButton(
        {double? width = 300,
        Color? background = defultColor,
        required VoidCallback function,
        required String text,
        double? radius = 10}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius!),
        color: background,
      ),
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 40,
            color: Colors.white,
          ),
        ),
      ),
    );

Future myNavigator({required context, required Widget}) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Widget),
    );

Future myNavigator2({required context, required Widget}) =>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Widget), (route) => false);

void showToast({required String text, required Color color}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
Widget myDivider() => Container(
  height: 1,
  width: double.infinity,
  color: Colors.grey,
);

Widget buildListProduct( model, context,{bool isOldPrice = true}) => Container(
  height: 120,
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        Container(
          height: 120,
          width: 120,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image!),
                width: double.infinity,
                height: 120,
              ),
              if (model.discount != 0 &&  isOldPrice)
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
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(fontSize: 20),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    ' ${model.price}',
                    style: const TextStyle(
                      color: defultColor,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  if (model.discount != 0 && isOldPrice )
                    Text(
                      '${model.oldPrice}',
                      style: TextStyle(
                        color: Colors.grey[700],
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        AppCubit.get(context)
                            .changeFavorites(model.id!);
                        print(model.id);
                      },
                      icon: AppCubit.get(context)
                          .favorites[model.id]!
                          ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                          : const Icon(Icons.favorite_border))
                ],
              ),
            ],
          ),
        )
      ],
    ),
  ),
);

Widget defaultAppBar({
  required Text text,
  BuildContext? context
}) => AppBar(
  title: text,
);
