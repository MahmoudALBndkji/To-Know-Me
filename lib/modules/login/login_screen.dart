import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:To_Know_Me/layout/social_layout.dart';
import 'package:To_Know_Me/modules/login/cubit/cubit.dart';
import 'package:To_Know_Me/modules/login/cubit/states.dart';
import 'package:To_Know_Me/modules/register/register_screen.dart';
import 'package:To_Know_Me/shared/components/components.dart';
import 'package:To_Know_Me/shared/network/local/cache_helper.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(
              message: state.error,
              state: ToastStates.ERROR,
            );
          }
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              navigateReplacementTo(
                context,
                SocialLayout(),
              );
            });
          }
        },
        builder: (context, state) {
          var cubit = SocialLoginCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 3.0,
                              color: Colors.grey[300],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 3.0,
                            ),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 28.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 3.0,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          SvgPicture.asset(
                            "assets/images/login1.svg",
                            width: 200.0,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
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
                            clipBehavior: Clip.antiAlias,
                            physics: BouncingScrollPhysics(),
                            children: [
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                "Login now to Communicate with friends",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Colors.grey, fontSize: 17.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,vertical: 15.0),
                                child: defaultTextFormField(
                                  controller: emailController,
                                  prefixIcon: Icons.email,
                                  labelText: "Email Address",
                                  keyboardType: TextInputType.emailAddress,
                                  validation: (value) {
                                    if (value!.isEmpty)
                                      return "Please Enter Your Email Address";
                                  },
                                  borderShape: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30.0),
                                      topLeft: Radius.circular(30.0),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,vertical: 15.0),
                                child: defaultTextFormField(
                                  onSubmit: (value) {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                  obscureText: cubit.isPassword,
                                  controller: passwordController,
                                  prefixIcon: Icons.password,
                                  suffixIcon: cubit.suffix,
                                  suffixPressed: () =>
                                      cubit.changePasswordVisibility(),
                                  labelText: "Password",
                                  keyboardType: TextInputType.visiblePassword,
                                  validation: (value) {
                                    if (value!.isEmpty)
                                      return "Please Enter Your Password";
                                  },
                                  borderShape: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(30.0),
                                      bottomLeft: Radius.circular(30.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              ConditionalBuilder(
                                condition: state is! SocialLoginLoadingState,
                                builder: (context) => defaultElevatedButton(
                                  text: "Login",
                                  borderRadius: 15.0,
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userLogin(
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Don\'t have an account?"),
                                  defaultTextButton(
                                    text: "Register",
                                    function: () => navigateTo(
                                      context,
                                      RegisterScreen(),
                                    ),
                                  ),
                                ],
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
