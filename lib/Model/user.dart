import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppUser {
  String? name;
  String? email;
  String? phone;
  String? image;
  String? uid;
  bool isDriver;

  AppUser({
    this.name,
    this.phone,
    this.uid,
    required this.email,
    required this.image,
    required this.isDriver,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'uid': uid,
      'image': image,
      'email': email,
      'isDriver': isDriver,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      isDriver: map['isDriver'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
