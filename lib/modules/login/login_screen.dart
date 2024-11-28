import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/lauout/home_layout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constentce.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppLoginSuccessState) {
          if (state.loginModel.status!) {
            showToast(text: state.loginModel.message!, color: Colors.green);
            CasheHelper.saveData(
                    key: 'token', value: state.loginModel.data!.token)
                .then((value) {
              token = '${state.loginModel.data!.token}';
              myNavigator2(context: context, Widget: HomeLayoutScreen());
            });
          } else {
            print(state.loginModel.message);
            showToast(text: state.loginModel.message!, color: Colors.red);
          }
        }
      },
      builder: (context, state) {
        var x = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Shop App',
                        style: TextStyle(
                          fontFamily: 'Ee',
                          fontSize: 45,
                        ),
                      ),
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontFamily: 'Aas',
                          fontSize: 45,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'login now to browse our hot offers ',
                        style: TextStyle(
                            fontSize: 20, color: Colors.deepPurpleAccent),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defultTextFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      defultTextFormField(
                          isPassword: x.isPassword,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              x
                                  .userLogin(
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((value) {
                                print(x.loginModel);
                              });
                            }
                          },
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          suffixPressed: () {
                            x.changePasswordVisibility();
                          },
                          suffix: x.suffix,
                          prefix: Icons.lock_outline,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'password is to short';
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        builder: (context) => defultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              x.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          text: 'login',
                        ),
                        condition: state is! AppLoginLoadingState,
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('don\`t have an account? '),
                          TextButton(
                              onPressed: () {
                                myNavigator(
                                    context: context, Widget: RegisterScreen());
                              },
                              child: const Text('REGISTER NOW'))
                        ],
                      ),
                      Lottie.network(
                          'https://assets4.lottiefiles.com/packages/lf20_9aaqrsgf.json',
                          width: 200,
                          height: 200)
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
