import 'dart:convert';

String playlistToJson(Playlist_model data) => json.encode(data.toJson());

class Playlist_model {
  String _id;
  String _nome;
  String _urlFoto;
  String _autorId;
  String _autorNome;
  List<Map> _musica;

  Playlist_model(String id, String nome, String urlFoto, String autorId,
      String autorNome, List<Map> musica) {
    this._id = id;
    this._nome = nome;
    this._urlFoto = urlFoto;
    this._autorId = autorId;
    this._autorNome = autorNome;
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

  String get urlFoto => _urlFoto;

  set urlFoto(String value) {
    this._urlFoto = value;
  }

  String get autorId => _autorId;

  set autor(String value) {
    _autorId = value;
  }

  String get autorNome => _autorNome;

  set autorNome(String value) {
    _autorNome = value;
  }

  List<Map> get musica => _musica;

  set musica(List<Map> value) {
    _musica = value;
  }

  fromJson(Map<String, dynamic> json) => Playlist_model(this._id, this._nome,
      this._urlFoto, this._autorId, this._autorNome, this._musica);

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "urlFoto": urlFoto,
        "autorId": autorId,
        "autorNome": autorNome,
        "musica": musica,
      };
}
