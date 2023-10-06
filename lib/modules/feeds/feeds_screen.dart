import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:To_Know_Me/adaptive/adaptive_indicator.dart';
import 'package:To_Know_Me/layout/cubit/cubit.dart';
import 'package:To_Know_Me/layout/cubit/states.dart';
import 'package:To_Know_Me/models/post_model.dart';
import 'package:To_Know_Me/modules/user_navigate/user_navigate.dart';
import 'package:To_Know_Me/shared/components/components.dart';
import 'package:To_Know_Me/shared/components/constants.dart';
import 'package:To_Know_Me/shared/styles/colors.dart';
import 'package:To_Know_Me/shared/styles/icon_broken.dart';
import 'package:social_share/social_share.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.posts.length > 0 && cubit.userModel != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.all(8.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            "https://img.freepik.com/free-photo/cheerful-positive-young-european-woman-with-dark-hair-broad-shining-smile-points-with-thumb-aside_273609-18325.jpg?t=st=1672385091~exp=1672385691~hmac=5f8130cf0db43de18c46da9fc934f09b82aaa330333e66b04d8179208d525a6e",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200.0,
                        placeholder: (context, url) => const SizedBox(
                          height: 200.0,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.pinkAccent,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Communicate With Friends",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      buildPostItem(cubit.posts[index], index, context),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 15.0,
                  ),
                  itemCount: cubit.posts.length,
                ),
                const SizedBox(
                  height: 15.0,
                ),
              ],
            ),
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

  Widget buildPostItem(PostModel model, index, context) =>
      BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Card(
            elevation: 10.0,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => navigateTo(
                          context,
                          UserNavigate(
                            postModel: model,
                            index: index,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: 50.0,
                            height: 50.0,
                            imageUrl: "${model.image}",
                            placeholder: (context, url) => SizedBox(
                              height: 40.0,
                              width: 40.0,
                              child: AdaptiveIndicator(
                                os: getOs(),
                                colorIndicator: Colors.pink,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${model.name}",
                                  style: TextStyle(
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Icon(
                                  Icons.check_circle,
                                  color: defaultColor,
                                  size: 19.0,
                                ),
                              ],
                            ),
                            Text(
                              "${model.dateTime}",
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        height: 1.3,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      IconButton(
                        onPressed: () {
                          // SocialCubit.get(context).showPopupMenu();
                          // print('Test Work Show Popup Menu');
                        },
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                  ),
                  SelectableText(
                    '${model.text}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),

                  /// tags

                  // Container(
                  //   margin: const EdgeInsets.symmetric(vertical: 3.0),
                  //   width: double.infinity,
                  //   child: Wrap(
                  //     spacing: 8.0,
                  //     children: [
                  //       SizedBox(
                  //         height: 20.0,
                  //         child: MaterialButton(
                  //           onPressed: () {},
                  //           minWidth: 1.0,
                  //           padding: EdgeInsets.zero,
                  //           child: Text(
                  //             "#Coding",
                  //             style: Theme
                  //                 .of(context)
                  //                 .textTheme
                  //                 .caption!
                  //                 .copyWith(
                  //               color: defaultColor,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 20.0,
                  //         child: MaterialButton(
                  //           onPressed: () {},
                  //           minWidth: 1.0,
                  //           padding: EdgeInsets.zero,
                  //           child: Text(
                  //             "#Developer",
                  //             style: Theme
                  //                 .of(context)
                  //                 .textTheme
                  //                 .caption!
                  //                 .copyWith(
                  //               color: defaultColor,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 20.0,
                  //         child: MaterialButton(
                  //           onPressed: () {},
                  //           minWidth: 1.0,
                  //           padding: EdgeInsets.zero,
                  //           child: Text(
                  //             "#Testing",
                  //             style: Theme
                  //                 .of(context)
                  //                 .textTheme
                  //                 .caption!
                  //                 .copyWith(
                  //               color: defaultColor,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 20.0,
                  //         child: MaterialButton(
                  //           onPressed: () {},
                  //           minWidth: 1.0,
                  //           padding: EdgeInsets.zero,
                  //           child: Text(
                  //             "#Software Enginnering",
                  //             style: Theme
                  //                 .of(context)
                  //                 .textTheme
                  //                 .caption!
                  //                 .copyWith(
                  //               color: defaultColor,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 20.0,
                  //         child: MaterialButton(
                  //           onPressed: () {},
                  //           minWidth: 1.0,
                  //           padding: EdgeInsets.zero,
                  //           child: Text(
                  //             "#Programming Language",
                  //             style: Theme
                  //                 .of(context)
                  //                 .textTheme
                  //                 .caption!
                  //                 .copyWith(
                  //               color: defaultColor,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  if (model.postImage != '')
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: SizedBox(
                          height: 160.0,
                          width: double.infinity,
                          child: InteractiveViewer(
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: "${model.postImage}",
                              placeholder: (context, url) => Center(
                                child: AdaptiveIndicator(
                                  os: getOs(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 7.0,
                      horizontal: 10.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                            ),
                            child: InkWell(
                              splashColor: Colors.pink[300],
                              child: Row(
                                children: [
                                  const Icon(
                                    IconBroken.Heart,
                                    size: 20.0,
                                    color: Colors.pink,
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    "${SocialCubit.get(context).likes[index]}",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              onTap: () {},
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                            ),
                            child: InkWell(
                              splashColor: Colors.amber[300],
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(
                                    IconBroken.Chat,
                                    size: 20.0,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    "28 Comment",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              onTap: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 10.0,
                    ),
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.grey[200],
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  width: 35.0,
                                  height: 35.0,
                                  imageUrl:
                                      "${SocialCubit.get(context).userModel!.image}",
                                  placeholder: (context, url) => const SizedBox(
                                    height: 35.0,
                                    width: 35.0,
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                "Write a Comment ...",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      InkWell(
                        splashColor: Colors.pink[300],
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              size: 20.0,
                              color: Colors.pink,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              "Like",
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {
                          SocialCubit.get(context).likePost(
                              SocialCubit.get(context).postsId[index]);
                        },
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      InkWell(
                        splashColor: Colors.blue[300],
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Send,
                              size: 20.0,
                              color: Colors.blue,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              "Share",
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                            ),
                            context: context,
                            builder: (ctx) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () => SocialShare.shareTelegram(
                                            '${model.postImage}\n ${model.text}'),
                                        child: Column(
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.telegram,
                                              color: Color(0xff0088cc)
                                                  .withOpacity(0.8),
                                              size: 40.0,
                                            ),
                                            Text(
                                              "Telegram",
                                              style: TextStyle(
                                                color: Color(0xff0088cc),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => SocialShare.shareWhatsapp(
                                            '${model.postImage}\n ${model.text}'),
                                        child: Column(
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.whatsapp,
                                              color:
                                                  Colors.teal.withOpacity(0.8),
                                              size: 40.0,
                                            ),
                                            Text(
                                              "WhatsApp",
                                              style: TextStyle(
                                                color: Colors.teal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => SocialShare.shareTwitter(
                                            '${model.postImage}\n ${model.text}'),
                                        child: Column(
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.twitter,
                                              color: Color(0xff1DA1F2)
                                                  .withOpacity(0.8),
                                              size: 40.0,
                                            ),
                                            Text(
                                              "Twitter",
                                              style: TextStyle(
                                                color: Color(0xff1DA1F2),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => SocialShare.shareSms(
                                            '${model.postImage}\n ${model.text}'),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.sms_outlined,
                                              color:
                                                  Colors.amber.withOpacity(0.7),
                                              size: 40.0,
                                            ),
                                            Text(
                                              "Sms",
                                              style: TextStyle(
                                                color: Colors.amber
                                                    .withOpacity(0.9),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
}
