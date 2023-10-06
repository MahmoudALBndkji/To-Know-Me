import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:To_Know_Me/layout/cubit/cubit.dart';
import 'package:To_Know_Me/layout/cubit/states.dart';
import 'package:To_Know_Me/models/user_model.dart';
import 'package:To_Know_Me/modules/chat_details/chat_details.dart';
import 'package:To_Know_Me/shared/components/components.dart';
import 'package:To_Know_Me/shared/styles/icon_broken.dart';

class UserDetails extends StatelessWidget {
  UserModel? model;
  int? index = 0;

  UserDetails({this.model, this.index});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var textTheme = Theme.of(context).textTheme;
        return Scaffold(
          appBar: AppBar(
            elevation: 0.1,
          ),
          body: Column(
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
                            imageUrl: "${cubit.users[index!].cover}",
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
                          imageUrl: "${cubit.users[index!].image}",
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
                "${cubit.users[index!].name}",
                style: textTheme.bodyText1,
              ),
              Text(
                "${cubit.users[index!].bio}",
                style: textTheme.caption,
              ),
              OutlinedButton(
                onPressed: () => navigateTo(
                    context,
                    ChatDetailsScreen(
                      userModel: model,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(IconBroken.Message),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "Type Your Message",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
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
