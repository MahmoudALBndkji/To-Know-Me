import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:To_Know_Me/layout/cubit/cubit.dart';
import 'package:To_Know_Me/layout/cubit/states.dart';
import 'package:To_Know_Me/modules/edit_profile/edit_profile.dart';
import 'package:To_Know_Me/modules/login/login_screen.dart';
import 'package:To_Know_Me/shared/components/components.dart';
import 'package:To_Know_Me/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialLogoutUserErrorState)
          showToast(
            message: state.error,
            state: ToastStates.ERROR,
          );
        else if(state is SocialLogoutUserSuccessState) {
          showToast(
            message: "Logout Successfully",
            state: ToastStates.SUCCESS,
          );
          navigateReplacementTo(
            context,
            LoginScreen(),
          );
        }
      },
      builder: (context, state) {
        var textTheme = Theme.of(context).textTheme;
        var userModel = SocialCubit.get(context).userModel;
        var cubit = SocialCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 200.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        child: SizedBox(
                          height: 160.0,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: "${userModel?.cover}",
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: Colors.pinkAccent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 3.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: 100.0,
                          height: 100.0,
                          imageUrl: "${userModel?.image}",
                          placeholder: (context, url) => const SizedBox(
                            height: 100.0,
                            width: 100.0,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${userModel?.name}",
                style: textTheme.bodyText1,
              ),
              Text(
                "${userModel?.bio}",
                style: textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              "${cubit.countPosts().toString()}",
                              style: textTheme.subtitle2,
                            ),
                            Text(
                              "Posts",
                              style: textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              "120",
                              style: textTheme.subtitle2,
                            ),
                            Text(
                              "Photos",
                              style: textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              "71.2 k",
                              style: textTheme.subtitle2,
                            ),
                            Text(
                              "Followers",
                              style: textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              "2,552",
                              style: textTheme.subtitle2,
                            ),
                            Text(
                              "Following",
                              style: textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      child: Text("Add Photos"),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  OutlinedButton(
                    onPressed: () => navigateTo(context, EditProfileScreen()),
                    child: Icon(
                      IconBroken.Edit,
                      size: 20.0,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      FirebaseMessaging.instance
                          .subscribeToTopic('announcements');
                    },
                    child: Text("subscribe"),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      FirebaseMessaging.instance
                          .unsubscribeFromTopic('announcements');
                    },
                    child: Text("unSubscribe"),
                  ),
                ],
              ),
              OutlinedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
                onPressed: () => cubit.signOut(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Icon(
                      IconBroken.Logout,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
