abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

/// Get Users
class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

/// Get All Users
class SocialGetAllUserLoadingState extends SocialStates {}

class SocialGetAllUserSuccessState extends SocialStates {}

class SocialGetAllUserErrorState extends SocialStates {
  final String error;

  SocialGetAllUserErrorState(this.error);
}

/// Get Posts
class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String error;

  SocialGetPostsErrorState(this.error);
}

/// Get Like Post
class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;

  SocialLikePostErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

/// Profile Image Picked
class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

/// Cover Image Picked
class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

/// Post Image Picked
class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

/// Upload Profile Image
class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

/// Upload Cover Image
class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

/// User Update
class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

/// Create Post
class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

/// Remove Post Image
class SocialRemovePostImageState extends SocialStates {}

/// Send Message
class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {}

/// Get Messages
class SocialGetMessagesSuccessState extends SocialStates {}

/// Add Friend
class SocialAddFriendLoadingState extends SocialStates {}

class SocialAddFriendSuccessState extends SocialStates {}

class SocialAddFriendErrorState extends SocialStates {
  final String error;

  SocialAddFriendErrorState(this.error);
}

/// Delete Friend
class SocialDeleteFriendLoadingState extends SocialStates {}

class SocialDeleteFriendSuccessState extends SocialStates {}

class SocialDeleteFriendErrorState extends SocialStates {
  final String error;

  SocialDeleteFriendErrorState(this.error);
}

/// Logout User
class SocialLogoutUserLoadingState extends SocialStates {}

class SocialLogoutUserSuccessState extends SocialStates {}

class SocialLogoutUserErrorState extends SocialStates {
  final String error;

  SocialLogoutUserErrorState(this.error);
}
class TestShow extends SocialStates {}

class SocialChangeIntroductionPage extends SocialStates{}
