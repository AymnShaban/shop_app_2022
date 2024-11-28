import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/search/search.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
     listener: (context,state){},
     builder: (context,state)  {
       var x = AppCubit.get(context);
       return Scaffold(
    appBar: AppBar(
    title: const Text('Shopping OnLine'),
    centerTitle: true,
      leading: IconButton(
        onPressed: (){
          myNavigator(context: context, Widget: LoginScreen());
        },
        icon: const Icon(Icons.abc),
      ),
      actions: [
        IconButton(onPressed: (){
          myNavigator(context: context, Widget: SearchScreen());
        }, icon: const Icon(Icons.search)),

      ],

    ),
    body: x.bottomScreens[x.currentIndex] ,
         bottomNavigationBar: BottomNavigationBar(
           currentIndex: x.currentIndex,
           onTap: (index){
             x.changeBottom(index);
           },
           items: const [
             BottomNavigationBarItem(icon: Icon(Icons.home_filled),
             label: 'Products',
             ),
             BottomNavigationBarItem(icon: Icon(Icons.category),
             label: 'categories',
             ),
             BottomNavigationBarItem(icon: Icon(Icons.favorite),
             label: 'Favorites',
             ),
             BottomNavigationBarItem(icon: Icon(Icons.settings),
             label: 'Settings',
             ),

           ],
         ),
    );
     },
    );
  }
}
