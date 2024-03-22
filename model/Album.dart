import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

String albumToJson(Album data) => json.encode(data.toJson());

class Album {
  String _id;
  String _nome;
  Timestamp _lancamento;
  String _urlFoto;
  String _artistaNome;
  String _artistaId;
  List<Map> _musica;

  Album(String id, String nome, Timestamp lancamento, String urlFoto,
      String artistaNome, String artistaId, List<Map> musica) {
    this._id = id;
    this._nome = nome;
    this._lancamento = lancamento;
    this._urlFoto = urlFoto;
    this._artistaNome = artistaNome;
    this._artistaId = artistaId;
    this._musica = musica;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get nome => _nome;

  set nome(String value) {
    this._nome = value;
  }

  Timestamp get lancamento => _lancamento;

  set lancamento(Timestamp value) {
    this._lancamento = value;
  }

  String get urlFoto => _urlFoto;

  set imagem(String value) {
    _urlFoto = value;
  }

  String get artistaId => _artistaId;

  set artistaId(String value) {
    _artistaId = value;
  }

  String get artistaNome => _artistaNome;

  set artistaNome(String value) {
    _artistaNome = value;
  }

  List<Map> get musica => _musica;

  set musica(List<Map> value) {
    _musica = value;
  }

  fromJson(Map<String, dynamic> json) => Album(
      this._id,
      this._nome,
      this._lancamento,
      this._urlFoto,
      this._artistaNome,
      this._artistaId,
      this._musica);

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "lancamento": lancamento,
        "urlFoto": urlFoto,
      };
}

// factory Album.fromJson(String id, Map<String, dynamic> json) => Album(
//       lancamento: DateTime.parse(json["lancamento"]),
//       idAlbum: id,
//       nome: json["nome"],
//     );

// Map<String, dynamic> toJson() => {
//       "lancamento":
//           "${lancamento.year.toString().padLeft(4, '0')}-${lancamento.month.toString().padLeft(2, '0')}-${lancamento.day.toString().padLeft(2, '0')}",
//       "id_album": idAlbum,
//       "nome": nome,
//     };
