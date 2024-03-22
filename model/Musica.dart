import 'dart:convert';

String musicaToJson(Musica data) => json.encode(data.toJson());

class Musica {
  String _id;
  String _nome;
  String _genero;
  String _albumId;
  String _albumNome;
  String _albumFoto;
  String _duracao;
  List<Map> _artista;

  Musica(String id, String nome, String genero, String albumId, String duracao,
      String albumFoto, String albumNome, List<Map> artista) {
    this._id = id;
    this._nome = nome;
    this._genero = genero;
    this._albumId = albumId;
    this._albumNome = albumNome;
    this._albumFoto = albumFoto;
    this._artista = artista;
    this._duracao = duracao;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get nome => _nome;

  set nome(String value) {
    this._nome = value;
  }

  String get genero => _genero;

  set genero(String value) {
    this._genero = value;
  }

  String get idAlbum => _albumId;

  set idAlbum(String value) {
    _albumId = value;
  }

  List<Map> get artista => _artista;

  set artista(List<Map> value) {
    _artista = value;
  }

  String get albumFoto => _albumFoto;

  set albumFoto(String value) {
    _albumFoto = value;
  }

  String get duracao => _duracao;

  set duracao(String value) {
    _duracao = value;
  }

  String get albumNome => _albumNome;

  set albumNome(String value) {
    _albumNome = value;
  }

  fromJson(Map<String, dynamic> json) => Musica(
      this._id,
      this._nome,
      this._genero,
      this._albumId,
      this._albumFoto,
      this._duracao,
      this._albumNome,
      this._artista);

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "genero": genero,
        "idAlbum": idAlbum,
        "artista": artista,
      };
}
