import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (ShopCubit.get(context).loginModel != null) {
          if (ShopCubit.get(context).loginModel!.status) {
            nameController.text = ShopCubit.get(context).loginModel!.data!.name;
            emailController.text =
                ShopCubit.get(context).loginModel!.data!.email;
            phoneController.text =
                ShopCubit.get(context).loginModel!.data!.phone;
          } else {
            showToast(
              text: ShopCubit.get(context).loginModel!.message,
              state: ToastStates.ERROR,
            );
          }
        }
        return (state != ShopLoadingUserDataState &&
                ShopCubit.get(context).loginModel != null)
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (state is ShopLoadingUpdateUserState)
                          const LinearProgressIndicator(),
                        const SizedBox(height: 15.0),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'name must not be empty';
                            }
                            return null;
                          },
                          label: 'Name',
                          prefixIcon: Icons.person,
                        ),
                        const SizedBox(height: 15.0),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'email must not be empty';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefixIcon: Icons.email,
                        ),
                        const SizedBox(height: 15.0),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'phone must not be empty';
                            }
                            return null;
                          },
                          label: 'Phone',
                          prefixIcon: Icons.phone,
                        ),
                        const SizedBox(height: 15.0),
                        defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopCubit.get(context).updateUserData(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                              );
                            }
                          },
                          text: 'update',
                        ),
                        const SizedBox(height: 15.0),
                        defaultButton(
                          function: () => signOut(context),
                          text: 'Logout',
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
