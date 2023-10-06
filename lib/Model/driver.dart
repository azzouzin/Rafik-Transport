// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Driver {
  final String name;
  final String email;
  final String? carmodele;
  final String rating;
  final String image;
  final String? phone;
  final String? uid;
  final bool? isDriver;

  Driver({
    required this.email,
    required this.image,
    required this.name,
    required this.carmodele,
    required this.rating,
    required this.phone,
    required this.isDriver,
    this.uid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'carmodele': carmodele,
      'rating': rating,
      'image': image,
      'email': email,
      'isDriver': isDriver,
      'uid': uid,
    };
  }

  factory Driver.fromMap(Map<String, dynamic> map) {
    return Driver(
      phone: map['phone'] as String?,
      name: map['name'] as String,
      carmodele: map['carmodele'] as String,
      rating: map['rating'] as String,
      image: map['image'] as String,
      email: map['email'] as String,
      uid: map['uid'] as String,
      isDriver: map['isDriver'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Driver.fromJson(String source) =>
      Driver.fromMap(json.decode(source) as Map<String, dynamic>);
}
