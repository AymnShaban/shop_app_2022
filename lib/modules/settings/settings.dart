import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constentce.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var model = AppCubit.get(context).userModel;
        nameController.text = '${model!.data!.name}';
        emailController.text = '${model.data!.email}';
        phoneController.text = '${model.data!.phone}';
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if(state is AppUpDateLoadingState)
                  const LinearProgressIndicator(),
                defultTextFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    label: 'Name',
                    prefix: Icons.person,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }
                    }),
                const SizedBox(height: 20),
                defultTextFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: 'Email',
                    prefix: Icons.email,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'email must not be empty';
                      }
                    }),
                const SizedBox(height: 20),
                defultTextFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    label: 'Phone',
                    prefix: Icons.phone,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'phone must not be empty';
                      }
                    }),
                const SizedBox(height: 20),
                defultButton(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        AppCubit.get(context).upDateUsersData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text);
                      }
                    },
                    text: 'UPDATE'),
                const SizedBox(height: 20),
                defultButton(
                    function: () {
                      signOut(context);
                    },
                    text: 'LOGOUT'),
              ],
            ),
          ),
        );
      },
    );
  }
}
