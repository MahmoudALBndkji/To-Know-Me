import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:To_Know_Me/adaptive/adaptive_indicator.dart';
import 'package:To_Know_Me/layout/cubit/cubit.dart';
import 'package:To_Know_Me/layout/cubit/states.dart';
import 'package:To_Know_Me/models/user_model.dart';
import 'package:To_Know_Me/modules/chat_details/chat_details.dart';
import 'package:To_Know_Me/shared/components/components.dart';
import 'package:To_Know_Me/shared/components/constants.dart';

class ChatsScreen extends StatelessWidget {
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
                buildChatItem(cubit.users[index], context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.users.length,
          ),
          fallback: (context) => Center(
            child: AdaptiveIndicator(
              os: getOs(),
            ),
          ),
        );
      },
    );
  }

  Widget buildChatItem(UserModel model, context) => InkWell(
        onTap: () {
          navigateTo(
            context,
            ChatDetailsScreen(
              userModel: model,
            ),
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
            ],
          ),
        ),
      );
}
