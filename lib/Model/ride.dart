// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rafik/Model/driver.dart';

class Ride {
  final String? from;
  final String? to;
  final String? price;
  final String? date;
  final int? seats;
  final Driver? driver;
  final GeoPoint? startpoint;
  final GeoPoint? endpoint;
  String? uid;
  final int totalSeats;
  Ride({
    this.from,
    this.to,
    this.price,
    this.date,
    this.seats,
    this.driver,
    this.uid,
    this.startpoint,
    this.endpoint,
    required this.totalSeats,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'from': from,
      'to': to,
      'price': price,
      'date': date,
      'seats': seats,
      'totalSeats': totalSeats,
      'driver': driver!.toMap(),
      'uid': uid,
      'startpoint': startpoint,
      'endpoint': endpoint,
    };
  }

  factory Ride.fromMap(Map<String, dynamic> map) {
    return Ride(
      from: map['from'] as String,
      to: map['to'] as String,
      price: map['price'] as String,
      date: map['date'] as String,
      seats: map['seats'] as int,
      totalSeats: map['totalSeats'] ?? 1 as int,
      driver: Driver.fromMap(map['driver'] as Map<String, dynamic>),
      uid: map['uid'] != null ? map['uid'] as String : null,
      startpoint:
          map['startpoint'] != null ? map['startpoint'] as GeoPoint : null,
      endpoint: map['endpoint'] != null ? map['endpoint'] as GeoPoint : null,
    );
  }

  List<Ride> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return Ride.fromMap(dataMap);
    }).toList();
  }

  String toJson() => json.encode(toMap());

  factory Ride.fromJson(String source) =>
      Ride.fromMap(json.decode(source) as Map<String, dynamic>);
}
