import 'package:flutter/material.dart';

class AgendaResponse {
  AgendaResponse({
    @required this.data,
    @required this.message,
  });

  final List<Agenda> data;
  final String message;

  factory AgendaResponse.fromJson(Map<String, dynamic> json) => AgendaResponse(
        data: json["data"].length == 0
            ? []
            : List<Agenda>.from(json["data"].map((x) => Agenda.fromJson(x))),
        message: json["message"],
      );
}

class Agenda {
  Agenda({
    @required this.id,
    @required this.judul,
    @required this.photo,
    @required this.link,
    @required this.tanggal,
    @required this.waktu,
    @required this.deskripsi,
  });

  final int id;
  final String judul;
  final String photo;
  final String link;
  final String tanggal;
  final String waktu;
  final String deskripsi;

  factory Agenda.fromJson(Map<String, dynamic> json) => Agenda(
        id: json["id"],
        judul: json["judul"],
        photo: json["photo"],
        link: json["link"],
        tanggal: json["tanggal"],
        waktu: json["waktu_mulai"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "photo": photo,
        "link": link,
        "tanggal": tanggal,
        "waktu_mulai": waktu,
        "deskripsi": deskripsi,
      };
}
