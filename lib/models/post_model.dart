class PostModel {
  String? name;
  String? uId;
  String? cover;
  String? image;
  String? bio;
  String? dateTime;
  String? text;
  String? postImage;

  PostModel({
    this.name,
    this.uId,
    this.cover,
    this.image,
    this.bio,
    this.dateTime,
    this.text,
    this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    cover = json['cover'];
    image = json['image'];
    bio = json['bio'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'cover': cover,
      'image': image,
      'bio': bio,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
    };
  }
}
