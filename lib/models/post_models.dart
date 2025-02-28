import 'dart:convert';

class Post {
  String? firstName;
  String? lastName;
  String? about;
  String? image_url;
  String? id;

  Post({this.firstName, this.lastName, this.about, this.image_url, this.id});

  Post.fromJson(Map<String, dynamic> json)
      : firstName = json["firstName"],
        lastName = json["lastName"],
        image_url = json["image_url"],
        about = json["about"],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "about": about,
        "image_url": image_url,
        'id': id
      };
}
