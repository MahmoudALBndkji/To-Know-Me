import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:To_Know_Me/layout/cubit/cubit.dart';
import 'package:To_Know_Me/layout/cubit/states.dart';
import 'package:To_Know_Me/shared/components/components.dart';
import 'package:To_Know_Me/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = userModel!.name!;
        phoneController.text = userModel.phone!;
        bioController.text = userModel.bio!;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: "Edit Profile",
            actions: [
              defaultTextButton(
                function: () {
                  cubit.updateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                },
                text: "Update",
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 200.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              InteractiveViewer(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ),
                                  child: SizedBox(
                                    height: 160.0,
                                    width: double.infinity,
                                    child: coverImage == null
                                        ? CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: "${userModel.cover}",
                                            placeholder: (context, url) =>
                                                const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.pinkAccent,
                                              ),
                                            ),
                                          )
                                        : Image(
                                            image: FileImage(coverImage),
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (ctx) => Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          title: Text("Camera"),
                                          leading:
                                              Icon(Icons.camera_alt_outlined),
                                          onTap: () {
                                            SocialCubit.get(context)
                                                .getCoverImage(
                                                    ImageSource.camera);
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
                                          leading:
                                              Icon(Icons.image_search_outlined),
                                          onTap: () {
                                            SocialCubit.get(context)
                                                .getCoverImage(
                                                    ImageSource.gallery);
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    IconBroken.Image_2,
                                    size: 20.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  width: 3.0,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: profileImage == null
                                    ? CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        width: 100.0,
                                        height: 100.0,
                                        imageUrl: "${userModel.image}",
                                        placeholder: (context, url) =>
                                            const SizedBox(
                                          height: 100.0,
                                          width: 100.0,
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : Image(
                                        image: FileImage(profileImage),
                                        fit: BoxFit.cover,
                                        width: 100.0,
                                        height: 100.0,
                                      ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (ctx) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        title: Text("Camera"),
                                        leading:
                                            Icon(Icons.camera_alt_outlined),
                                        onTap: () {
                                          cubit.getProfileImage(
                                              ImageSource.camera);
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
                                        leading:
                                            Icon(Icons.image_search_outlined),
                                        onTap: () {
                                          cubit.getProfileImage(
                                              ImageSource.gallery);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: CircleAvatar(
                                backgroundColor: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .color!
                                    .withOpacity(0.8),
                                radius: 20.0,
                                child: Icon(
                                  IconBroken.Image,
                                  size: 20.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (cubit.profileImage != null || cubit.profileImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultElevatedButton(
                                  function: () {
                                    cubit.uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  height: 40.0,
                                  text: "Upload Profile",
                                  borderRadius: 20.0,
                                ),
                                if (state is SocialUserUpdateLoadingState)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is SocialUserUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        SizedBox(
                          width: 10.0,
                        ),
                        if (cubit.coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultElevatedButton(
                                  function: () {
                                    cubit.uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  height: 40.0,
                                  text: "Upload Cover",
                                  borderRadius: 20.0,
                                ),
                                if (state is SocialUserUpdateLoadingState)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is SocialUserUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (cubit.profileImage != null || cubit.profileImage != null)
                    SizedBox(
                      height: 20.0,
                    ),
                  defaultTextFormField(
                    controller: nameController,
                    context: context,
                    keyboardType: TextInputType.name,
                    validation: (value) {
                      if (value.isEmpty) return "name must not be Empty";
                    },
                    labelText: "Name",
                    prefixIcon: IconBroken.User,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultTextFormField(
                    controller: phoneController,
                    context: context,
                    keyboardType: TextInputType.phone,
                    validation: (value) {
                      if (value.isEmpty)
                        return "phone number must not be Empty";
                    },
                    labelText: "Phone",
                    prefixIcon: IconBroken.Call,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultTextFormField(
                    controller: bioController,
                    context: context,
                    keyboardType: TextInputType.name,
                    validation: (value) {
                      if (value.isEmpty) return "bio must not be Empty";
                    },
                    labelText: "Bio",
                    prefixIcon: IconBroken.Info_Circle,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
