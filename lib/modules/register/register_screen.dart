import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../lauout/home_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constentce.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/network/local/cashe_helper.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {


    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppRegisterSuccessState) {
          if (state.registerModel.status!) {

            showToast(text: state.registerModel.message!, color: Colors.green);
            CasheHelper.saveData(
                key: 'token', value: state.registerModel.data!.token).then((
                value) {
              token = '${state.registerModel.data!.token}';
              myNavigator2(context: context, Widget: HomeLayoutScreen());
            });
          } else {
            print(state.registerModel.message);
            showToast(text: state.registerModel.message!, color: Colors.red);
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
                        'Register now to browse our hot offers ',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defultTextFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'User Name',
                          prefix: Icons.person,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                          }),
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
                        height: 15,
                      ),
                      defultTextFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone Numper',
                          prefix: Icons.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone numper';
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        builder: (context) => defultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              x.registerLogin(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text)
                                  .then((value) {
                              });
                            }
                          },
                          text: 'register',
                        ),
                        condition: state is! AppRegisterLoadingState,
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
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
