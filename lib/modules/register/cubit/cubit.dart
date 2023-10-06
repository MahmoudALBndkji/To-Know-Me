import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:To_Know_Me/models/user_model.dart';
import 'package:To_Know_Me/modules/register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        name: name,
        phone: phone,
        email: email,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String phone,
    required String email,
    required String uId,
  }) {
    UserModel userModel = UserModel(
      name: name,
      phone: phone,
      email: email,
      uId: uId,
      image: 'https://img.freepik.com/free-photo/attractive-young-man-wearing-glasses-casual-clothes-showing-thumbs-up-approval-like-something-standing-against-blue-background_1258-66572.jpg?t=st=1672493284~exp=1672493884~hmac=c01bd0fe48a5306c63b8f6ebcc89dc3769f2523970282acda57c059f4691a8a3',
      cover: 'https://img.freepik.com/free-psd/fiddle-leaf-fig-room_53876-89633.jpg?w=1060&t=st=1672493507~exp=1672494107~hmac=2855b7028160bfe82c68c1269d711b1be0bcb840f93853d8bac0eb3cd1daea7e',
      bio: 'write you bio ...',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterPasswordVisibilityState());
  }
}
