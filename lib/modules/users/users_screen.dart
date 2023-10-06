import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:To_Know_Me/layout/cubit/cubit.dart';
import 'package:To_Know_Me/layout/cubit/states.dart';
import 'package:To_Know_Me/models/user_model.dart';
import 'package:To_Know_Me/modules/user_details/user_details.dart';
import 'package:To_Know_Me/shared/components/components.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.users.length > 0,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildUserItem(cubit.users[index], context, index),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.users.length,
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildUserItem(UserModel model, context, index) => InkWell(
        onTap: () {
          navigateTo(
            context,
            UserDetails(model: model, index: index),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: 50.0,
                  height: 50.0,
                  imageUrl: "${model.image}",
                  placeholder: (context, url) => const SizedBox(
                    height: 40.0,
                    width: 40.0,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Text(
                "${model.name}",
                style: TextStyle(
                  height: 1.3,
                ),
              ),
              Spacer(),
              BlocConsumer<SocialCubit, SocialStates>(
                listener: (context, state) {
                  if (state is SocialAddFriendLoadingState) {
                    showToast(
                        message: "Request Sent", state: ToastStates.SUCCESS);
                  }
                },
                builder: (context, state) {
                  if (state is! SocialAddFriendLoadingState)
                    return defaultTextButton(
                      isUpper: false,
                      function: () => SocialCubit.get(context).addFriend(),
                      text: "Add Friend",
                    );
                  return OutlinedButton(
                    onPressed: null,
                    child: Text("Waiting replay"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.amber.withOpacity(0.3)),
                      side: MaterialStateProperty.all(
                        BorderSide(
                          width: 2.0,
                          color: Colors.amber.withOpacity(0.5),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
}
