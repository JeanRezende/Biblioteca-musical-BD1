import 'dart:convert';

//Artista artistaFromJson(String str) => Artista.fromJson(json.decode(str));

String artistaToJson(Artista data) => json.encode(data.toJson());

class Artista {
  String _id;
  String _nome;
  String _urlFoto;

  Artista(String id, String nome, String urlFoto) {
    this._id = id;
    this._nome = nome;
    this._urlFoto = urlFoto;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get nome => _nome;

  set nomeA(String value) {
    this._nome = value;
  }

  String get urlFoto => _urlFoto;

  set imagem(String value) {
    _urlFoto = value;
  }

  fromJson(Map<String, dynamic> json) =>
      Artista(this._id, this._nome, this._urlFoto);

  Map<String, dynamic> toJson() => {
        "id_artista": id,
        "nome": nome,
        "urlFoto": urlFoto,
      };
}
