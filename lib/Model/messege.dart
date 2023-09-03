// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Messege {
  final String senderid;
  final String date;
  final String recieverid;
  final String? imgurl;
  final String text;

  Messege(
      {required this.senderid,
      required this.text,
      required this.date,
      required this.recieverid,
      this.imgurl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderid': senderid,
      'date': date,
      'recieverid': recieverid,
      'imgurl': imgurl == null
          ? "https://img.freepik.com/photos-gratuite/homme-age-mur-portant-penchee-fond-couleur-rouillee_150588-73.jpg?w=360&t=st=1690450715~exp=1690451315~hmac=5dad42e0bc0a3cb555c6a6700ffe53e81e8e5604e3e3d1e4afe09d36c028350d"
          : imgurl,
      'text': text,
    };
  }

  factory Messege.fromMap(Map<String, dynamic> map) {
    return Messege(
      senderid: map['senderid'] as String,
      date: map['date'] as String,
      recieverid: map['recieverid'] as String,
      imgurl: map['imgurl'] == null
          ? "https://img.freepik.com/photos-gratuite/homme-age-mur-portant-penchee-fond-couleur-rouillee_150588-73.jpg?w=360&t=st=1690450715~exp=1690451315~hmac=5dad42e0bc0a3cb555c6a6700ffe53e81e8e5604e3e3d1e4afe09d36c028350d"
          : map['imgurl'] as String,
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Messege.fromJson(String source) =>
      Messege.fromMap(json.decode(source) as Map<String, dynamic>);
}
