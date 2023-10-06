import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:To_Know_Me/layout/cubit/cubit.dart';
import 'package:To_Know_Me/layout/cubit/states.dart';
import 'package:To_Know_Me/modules/new_post/new_post.dart';
import 'package:To_Know_Me/modules/search/search_screen.dart';
import 'package:To_Know_Me/shared/components/components.dart';
import 'package:To_Know_Me/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState)
          navigateTo(
            context,
            NewPostScreen(),
          );
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            elevation: 0.0,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  IconBroken.Notification,
                ),
              ),
              IconButton(
                onPressed: () => navigateTo(context, SearchScreen()),
                icon: const Icon(
                  IconBroken.Search,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: NavigationBar(
            elevation: 0.0,
            // light Theme
            // backgroundColor: Color(0xFFEEEEEE),
            // dark Theme
            // backgroundColor: HexColor('#292C2E'),
            selectedIndex: cubit.currentIndex,
            onDestinationSelected: (index) {
              cubit.changeBottomNav(index);
            },
            destinations: [
              NavigationDestination(
                icon: Icon(IconBroken.Home),
                label: "Home",
              ),
              NavigationDestination(
                icon: Icon(IconBroken.Chat),
                label: "Chats",
              ),
              NavigationDestination(
                icon: Icon(IconBroken.Paper_Upload),
                label: "Post",
              ),
              NavigationDestination(
                icon: Icon(IconBroken.Location),
                label: "Users",
              ),
              NavigationDestination(
                icon: Icon(IconBroken.Setting),
                label: "Settings",
              ),
            ],
          ),
        );
      },
    );
  }
}
