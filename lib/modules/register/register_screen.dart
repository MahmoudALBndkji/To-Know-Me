import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:To_Know_Me/layout/social_layout.dart';
import 'package:To_Know_Me/modules/register/cubit/cubit.dart';
import 'package:To_Know_Me/modules/register/cubit/states.dart';
import 'package:To_Know_Me/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            navigateReplacementTo(
              context,
              SocialLayout(),
            );
          }
        },
        builder: (context, state) {
          var cubit = SocialRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          SvgPicture.asset(
                            "assets/images/register1.svg",
                            height: 200.0,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50.0),
                                topLeft: Radius.circular(50.0),
                              ),
                            ),
                          ),
                          ListView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                "Register now to Communicate with friends",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Colors.grey, fontSize: 17.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 20.0, 20.0, 15.0),
                                child: defaultTextFormField(
                                  controller: nameController,
                                  prefixIcon: Icons.person_outline,
                                  labelText: "User Name",
                                  keyboardType: TextInputType.name,
                                  validation: (value) {
                                    if (value.isEmpty)
                                      return "Please Enter Your Name";
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                child: defaultTextFormField(
                                  controller: phoneController,
                                  prefixIcon: Icons.phone,
                                  labelText: "Phone",
                                  keyboardType: TextInputType.phone,
                                  validation: (value) {
                                    if (value.isEmpty)
                                      return "Please Enter Your Phone";
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                child: defaultTextFormField(
                                  controller: emailController,
                                  prefixIcon: Icons.email,
                                  labelText: "Email Address",
                                  keyboardType: TextInputType.emailAddress,
                                  validation: (value) {
                                    if (value.isEmpty)
                                      return "Please Enter Your Email Address";
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                child: defaultTextFormField(
                                  obscureText: cubit.isPassword,
                                  controller: passwordController,
                                  prefixIcon: Icons.password,
                                  suffixIcon: cubit.suffix,
                                  suffixPressed: () =>
                                      cubit.changePasswordVisibility(),
                                  labelText: "Password",
                                  keyboardType: TextInputType.visiblePassword,
                                  validation: (value) {
                                    if (value.isEmpty)
                                      return "Please Enter Your Password";
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              ConditionalBuilder(
                                condition: state is! SocialRegisterLoadingState,
                                builder: (context) => defaultElevatedButton(
                                  text: "register",
                                  borderRadius: 15.0,
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userRegister(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                ),
                                fallback: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
