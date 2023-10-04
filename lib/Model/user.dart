import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppUser {
  String? name;

  String? phone;
  String? image;
  String? uid;

  AppUser({
    this.name,
    this.phone,
    this.uid,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'uid': uid,
      'image': image,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map['name'] != null ? map['name'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
