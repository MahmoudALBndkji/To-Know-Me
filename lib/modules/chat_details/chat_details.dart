import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:To_Know_Me/adaptive/adaptive_indicator.dart';
import 'package:To_Know_Me/layout/cubit/cubit.dart';
import 'package:To_Know_Me/layout/cubit/states.dart';
import 'package:To_Know_Me/models/message_model.dart';
import 'package:To_Know_Me/models/user_model.dart';
import 'package:To_Know_Me/shared/components/components.dart';
import 'package:To_Know_Me/shared/components/constants.dart';
import 'package:To_Know_Me/shared/styles/colors.dart';
import 'package:To_Know_Me/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel? userModel;
  TextEditingController messageController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  ChatDetailsScreen({this.userModel});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receiverId: userModel!.uId!);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SocialCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                elevation: 0.1,
                title: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: 50.0,
                        height: 50.0,
                        imageUrl: "${userModel!.image}",
                        placeholder: (context, url) => const SizedBox(
                          height: 40.0,
                          width: 40.0,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    SizedBox(),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      "${userModel!.name}",
                      style: TextStyle(
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: cubit.messages.length >= 0,
                builder: (context) => Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message = cubit.messages[index];
                            if (cubit.userModel!.uId == message.senderId)
                              return buildMyMessage(message);
                            return buildMessage(message);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 15.0,
                          ),
                          itemCount: cubit.messages.length,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 30.0),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(0xff717D8D),
                        ),
                        // color: Color(0xff212D3B).withOpacity(0.7),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 40.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty)
                                      showToast(
                                        showDuration: Toast.LENGTH_SHORT,
                                        showTimeForWeb: 2,
                                        state: ToastStates.ERROR,
                                        message: "message can not null",
                                      );
                                  },
                                  controller: messageController,
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "type your message here ...",
                                    hintStyle: TextStyle(),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (formKey.currentState!.validate())
                                  cubit.sendMessage(
                                    receiverId: userModel!.uId!,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                messageController.clear();
                              },
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(end: 20.0),
                                child: Icon(
                                  IconBroken.Send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => Center(
                  child:  AdaptiveIndicator(
                    os: getOs(),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel messageModel) => Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            child: Text("${messageModel.text}"),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
              ),
            ),
          ),
        ),
      );

  Widget buildMyMessage(MessageModel messageModel) => Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            child: Text("${messageModel.text}"),
            decoration: BoxDecoration(
              color: defaultColor.withOpacity(0.2),
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
              ),
            ),
          ),
        ),
      );
}
