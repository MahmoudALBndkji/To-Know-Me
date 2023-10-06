import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:To_Know_Me/layout/cubit/states.dart';
import 'package:To_Know_Me/models/message_model.dart';
import 'package:To_Know_Me/models/post_model.dart';
import 'package:To_Know_Me/models/user_model.dart';
import 'package:To_Know_Me/modules/chats/chats_screen.dart';
import 'package:To_Know_Me/modules/feeds/feeds_screen.dart';
import 'package:To_Know_Me/modules/login/login_screen.dart';
import 'package:To_Know_Me/modules/new_post/new_post.dart';
import 'package:To_Know_Me/modules/settings/settings_screen.dart';
import 'package:To_Know_Me/modules/users/users_screen.dart';
import 'package:To_Know_Me/shared/components/components.dart';
import 'package:To_Know_Me/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:To_Know_Me/shared/network/local/cache_helper.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  final GlobalKey<PopupMenuButtonState<int>> _menuKey = GlobalKey();

  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    "Home",
    "Chats",
    "Post",
    "Users",
    "Settings",
  ];

  void changeBottomNav(int index) {
    // if (index == 1) getAllUsers();
    if (index == 2)
      emit(SocialNewPostState());
    else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  final ImagePicker picker = ImagePicker();

  Future<void> getProfileImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print("No Image Selected");
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print("No Image Selected");
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUserUpdateLoadingState());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   }
  //   else if (profileImage != null) {
  //     uploadProfileImage();
  //   }
  //   else if (profileImage != null && coverImage != null) {
  //   }
  //   else {
  //     updateUser(
  //       name: name,
  //       phone: phone,
  //       bio: bio,
  //     );
  //   }
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      uId: userModel!.uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print("No Image Selected");
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      // userModel: userModel,
      name: userModel!.name,
      cover: userModel!.cover,
      image: userModel!.image,
      bio: userModel!.bio,
      uId: userModel!.uId,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }
   // Test For Get all posts from particular user
    // FirebaseFirestore.instance.collection('posts').doc(FirebaseAuth.instance.currentUser!.uid)
  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(
            PostModel.fromJson(
              element.data(),
            ),
          );
          emit(SocialGetPostsSuccessState());
        }).catchError((error) {
          emit(SocialGetPostsErrorState(error.toString()));
        });
      });
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];

  void getAllUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId)
            users.add(
              UserModel.fromJson(
                element.data(),
              ),
            );
        });
        emit(SocialGetAllUserSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUserErrorState(error.toString()));
      });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel messageModel = MessageModel(
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      text: text,
    );
    // set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    // set receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessagesSuccessState());
    });
  }

  Future<void> signOut() async {
    emit(SocialLogoutUserLoadingState());
    await FirebaseAuth.instance.signOut().then((value) {
      emit(SocialLogoutUserSuccessState());
      CacheHelper.removeData(key: 'uId');
    }).catchError((error) => emit(SocialLogoutUserErrorState(error)));
  }

// Future<void> signOut() async {
//   emit(SocialLogoutUserLoadingState());
//   await FirebaseAuth.instance
//       .signOut()
//       .then((value) => emit(SocialLogoutUserSuccessState()))
//       .catchError((error) => emit(SocialLogoutUserErrorState(error)));
// }

  Future<void> addFriend() async {
    emit(SocialAddFriendLoadingState());
  }

  void showPopupMenu() {
    emit(TestShow());
    PopupMenuButton(
      key: _menuKey,
      itemBuilder: (context) {
        return <PopupMenuEntry<int>>[
          PopupMenuItem(child: Text('0'), value: 0),
          PopupMenuItem(child: Text('1'), value: 1),
        ];
      },
    );
  }

  int currentIntroductionIndex = 0;
  void changeIntroductionPageIndex(int index) => currentIntroductionIndex = index;
  bool isLastIntroductionPage = false;

  void changeIntroductionPage(bool isLast) {
    emit(SocialChangeIntroductionPage());
    isLastIntroductionPage = isLast;
  }

  void navigateLogin(context) {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigateReplacementTo(
          context,
          LoginScreen(),
        );
      }
    });
  }

  final CollectionReference<Map<String, dynamic>> postsList = FirebaseFirestore.instance.collection('posts');

  Future<int> countPosts() async {
    AggregateQuerySnapshot query = await postsList.count().get();
    debugPrint('The number of Posts: ${query.count}');
    return query.count;
  }
}
