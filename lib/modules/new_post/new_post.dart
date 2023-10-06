import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:To_Know_Me/layout/cubit/cubit.dart';
import 'package:To_Know_Me/layout/cubit/states.dart';
import 'package:To_Know_Me/shared/components/components.dart';
import 'package:To_Know_Me/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              defaultTextButton(
                function: () {
                  var now = DateTime.now();
                  if (cubit.postImage == null)
                    cubit.createPost(
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                  else
                    cubit.uploadPostImage(
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                },
                text: 'Post',
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: 50.0,
                        height: 50.0,
                        imageUrl:
                            "${cubit.userModel!.image}",
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
                    Expanded(
                      child: Text(
                        "${cubit.userModel!.name}",
                        style: TextStyle(
                          height: 1.3,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'what is on your mind ...',
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if (cubit.postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      InteractiveViewer(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: SizedBox(
                            height: 160.0,
                            width: double.infinity,
                            child: Image(
                              image: FileImage(cubit.postImage!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: "Remove",
                        onPressed: () {
                          cubit.removePostImage();
                        },
                        icon: CircleAvatar(
                          radius: 20.0,
                          child: Icon(
                            Icons.close,
                            size: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 25.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (ctx) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text("Camera"),
                                  leading: Icon(Icons.camera_alt_outlined),
                                  onTap: () {
                                    cubit.getPostImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 1.0,
                                  height: 1.0,
                                ),
                                ListTile(
                                  title: Text("Gallery"),
                                  leading: Icon(Icons.image_search_outlined),
                                  onTap: () {
                                    cubit.getPostImage(ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text("add photo"),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text("# tags"),
                      ),
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
}
