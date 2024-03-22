import 'package:bibliMusical/model/Album.dart';
import 'package:bibliMusical/model/Artista.dart';
import 'package:bibliMusical/model/Musica.dart';
import 'package:bibliMusical/model/Playlist_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBHelper {
  FirebaseFirestore db = FirebaseFirestore.instance;

  //busca todas playlists existentes
  Future<List<Playlist_model>> buscaPlaylist() async {
    List<Playlist_model> list = new List();
    var musicas = <Map>[];
    try {
      QuerySnapshot querySnapshot = await db.collection("playlist").get();
      for (DocumentSnapshot item in querySnapshot.docs) {
        List m = item.data()["musica"];

        for (int i = 0; i < m.length; i++) {
          musicas.add(item.data()["musica"][i]);
        }

        list.add(Playlist_model(
            item.id,
            item.data()["nome"],
            item.data()["urlFoto"],
            item.data()["autor_id"],
            item.data()["autor_nome"],
            musicas));
      }

      return list;
    } catch (e) {
      return e;
    }
  }

  //busca playlist por id
  Future<Playlist_model> buscaPlaylistbyId(String chave) async {
    var musicas = <Map>[];
    try {
      var document = db.collection("playlist").doc(chave);
      var item = await document.get();
      List m = item.data()["musica"];

      for (int i = 0; i < m.length; i++) {
        musicas.add(item.data()["musica"][i]);
      }

      var retorno = Playlist_model(
          item.id,
          item.data()["nome"],
          item.data()["urlFoto"],
          item.data()["autor_id"],
          item.data()["autor_nome"],
          musicas);
      return retorno;
    } catch (e) {
      return e;
    }
  }

  //busca musica por id
  Future<Musica> buscaMusica(String idMusica) async {
    var artistas = <Map>[];
    try {
      //print("id da musica: " + idMusica);
      DocumentSnapshot snapshot =
          await db.collection("musica").doc(idMusica).get();

      List m = snapshot.data()["artista"];

      for (int i = 0; i < m.length; i++) {
        artistas.add(snapshot.data()["musica"][i]);
      }
      //print("musica encontrada" + snapshot.data["nome"]);
      return Musica(
          snapshot.id,
          snapshot.data()["nome"],
          snapshot.data()["genero"],
          snapshot.data()["album_id"],
          snapshot.data()["duracao"],
          snapshot.data()["album_urlFoto"],
          snapshot.data()["album_Nome"],
          artistas);
    } catch (e) {
      return e;
    }
  }

  //buscando todos os generos listados
  Future<List<String>> buscaGenero() async {
    List<String> list = new List();
    try {
      QuerySnapshot querySnapshot = await db.collection("musica").get();
      for (DocumentSnapshot item in querySnapshot.docs) {
        list.add(item.data()["genero"]);
      }
      return list.toSet().toList(); //retorna sem valores repetidos
    } catch (e) {
      return e;
    }
  }

  //buscando todas as musicas de apenas um genero
  Future<List<Musica>> buscaGeneroMusica(String genero) async {
    List<Musica> list = new List();
    var artistas = <Map>[];
    try {
      QuerySnapshot querySnapshot = await db
          .collection("musica")
          .where("genero", isEqualTo: genero)
          .get();
      for (DocumentSnapshot item in querySnapshot.docs) {
        List m = item.data()["artista"];
        if (m.length > 0) {
          for (int i = 0; i < m.length; i++) {
            artistas.add(item.data()["artista"][i]);
          }
        }
        list.add(Musica(
            item.id,
            item.data()["nome"],
            item.data()["genero"],
            item.data()["album_id"],
            item.data()["duracao"],
            item.data()["album_urlFoto"],
            item.data()["album_Nome"],
            artistas));
      }
      //print(list.toString());
      return list;
    } catch (e) {
      return e;
    }
  }

  //buscando todos artistas
  Future<List<Artista>> buscaArtista() async {
    try {
      List<Artista> list = List();
      QuerySnapshot querySnapshot = await db.collection("artista").get();
      for (DocumentSnapshot item in querySnapshot.docs) {
        list.add(Artista(item.id, item.data()["nome"], item.data()["urlFoto"]));
      }
      return list;
    } catch (e) {
      return e;
    }
  }

  //buscando albuns que o artista tem
  Future<List<Album>> buscaAlbumArtista(String idArtista) async {
    List<Album> list = List();
    try {
      QuerySnapshot querySnapshot = await db
          .collection("album")
          .where("artista_id", isEqualTo: idArtista)
          .get();
      for (DocumentSnapshot item in querySnapshot.docs) {
        list.add(Album(
            item.id,
            item.data()["nome"],
            item.data()["lancamento"],
            item.data()["urlFoto"],
            item.data()["artista_nome"],
            item.data()["artista_id"], <Map>[]));
      }
      print(list.asMap().toString());
      return list;
    } catch (e) {
      return e;
    }
  }

  //busca by nome ---------------------------------------------------

  Future<Artista> buscaArtistabyNome(String chave) async {
    Artista artista;
    try {
      QuerySnapshot querySnapshot =
          await db.collection("artista").where("nome", isEqualTo: chave).get();
      for (DocumentSnapshot item in querySnapshot.docs) {
        artista = Artista(item.id, item.data()["nome"], item.data()["urlFoto"]);
      }
      print(artista.toJson());
      return artista;
    } catch (e) {
      return e;
    }
  }

  Future<Map<String, dynamic>> buscaPlaylistbyNome(String chave) async {
    Map<String, dynamic> retorno;
    try {
      QuerySnapshot querySnapshot =
          await db.collection("playlist").where("nome", isEqualTo: chave).get();
      for (DocumentSnapshot item in querySnapshot.docs) {
        retorno = {
          "id": item.id,
          "nome": item.data()["nome"],
          "urlFoto": item.data()["urlFoto"],
        };
      }
      print(retorno.toString());
      return retorno;
    } catch (e) {
      return e;
    }
  }

  Future<Map<String, dynamic>> buscaAlbumbyNome(String chave) async {
    Map<String, dynamic> retorno;
    try {
      QuerySnapshot querySnapshot =
          await db.collection("album").where("nome", isEqualTo: chave).get();
      for (DocumentSnapshot item in querySnapshot.docs) {
        retorno = {
          "id": item.id,
          "nome": item.data()["nome"],
          "urlFoto": item.data()["urlFoto"],
        };
      }
      print(retorno.toString());
      return retorno;
    } catch (e) {
      return e;
    }
  }

  Future<Map<String, dynamic>> buscaMusicabyNome(String chave) async {
    Map<String, dynamic> retorno;
    try {
      QuerySnapshot querySnapshot =
          await db.collection("musica").where("nome", isEqualTo: chave).get();

      for (DocumentSnapshot item in querySnapshot.docs) {
        retorno = {
          "id": item.id,
          "nome": item.data()["nome"],
          "duracao": item.data()["duracao"],
        };
      }
      print(retorno.toString());
      return retorno;
    } catch (e) {
      return e;
    }
  }

  void updates() async {
    // try {
    //albuns
    var views = await buscaAlbumbyNome("Views");
    var scorpion = await buscaAlbumbyNome("Scorpion");
    var suncity = await buscaAlbumbyNome("Suncity");
    var anti = await buscaAlbumbyNome("Anti Deluxe");
    var menosemais = await buscaAlbumbyNome("Menos É Mais");

    var drake = await buscaArtistabyNome("Drake");
    var khalid = await buscaArtistabyNome("Khalid");
    var rihanna = await buscaArtistabyNome("Rihanna");
    var hej = await buscaArtistabyNome("Henrique e Juliano");

    Map<String, dynamic> hotlineBling =
        await buscaMusicabyNome("Hotline Bling");
    Map<String, dynamic> godsplan = await buscaMusicabyNome("God's Plan");
    Map<String, dynamic> oneDance = await buscaMusicabyNome("One Dance");
    Map<String, dynamic> suncitym = await buscaMusicabyNome("Suncity");
    Map<String, dynamic> trescoracoes =
        await buscaMusicabyNome("Três Corações");
    Map<String, dynamic> vaiquebebereis =
        await buscaMusicabyNome("Vai que Bebereis");

    Map<String, dynamic> playlist1 = await buscaPlaylistbyNome("Playlist 1");
    Map<String, dynamic> playlist2 = await buscaPlaylistbyNome("Playlist 2");

    db.collection("album").doc(views["id"]).update({
      "nome": "Views",
      "urlFoto": "https://zh.rbsdirect.com.br/imagesrc/19193089.jpg?w=700",
      "lancamento": Timestamp.fromDate(DateTime(2017)),
      "artista_id": drake.id,
      "artista_nome": drake.nome,
      "musica": [
        {
          "id": hotlineBling["id"],
          "nome": hotlineBling["nome"],
          "duracao": hotlineBling["duracao"],
        }
      ]
    });
    db.collection("album").doc(scorpion["id"]).update({
      "nome": "Scorpion",
      "urlFoto":
          "https://upload.wikimedia.org/wikipedia/pt/c/c2/Scorpion_Drake.jpg",
      "lancamento": Timestamp.fromDate(DateTime(2018)),
      "artista_id": drake.id,
      "artista_nome": drake.nome,
      "musica": [
        {
          "id": godsplan["id"],
          "nome": godsplan["nome"],
          "duracao": godsplan["duracao"]
        }
      ]
    });

    db.collection("album").doc(suncity["id"]).update({
      "nome": "Suncity",
      "urlFoto":
          "https://images.genius.com/48ca10fe4ca2ae201fa0b0437c13d72c.1000x1000x1.jpg",
      "lancamento": Timestamp.fromDate(DateTime(2016)),
      "artista_id": khalid.id,
      "artista_nome": khalid.nome,
      "musica": [
        {
          "id": suncitym["id"],
          "nome": suncitym["nome"],
          "duracao": suncitym["duracao"]
        }
      ]
    });

    db.collection("album").doc(anti["id"]).update({
      "nome": "Anti Deluxe",
      "urlFoto":
          "https://img.discogs.com/1N4c7Yba0bblMS46XyOk4cUI-hs=/fit-in/600x494/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-8393847-1460755973-3600.jpeg.jpg",
      "lancamento": Timestamp.fromDate(DateTime(2017)),
      "artista_id": rihanna.id,
      "artista_nome": rihanna.nome,
      "musica": [
        {
          "id": suncitym["id"],
          "nome": suncitym["nome"],
          "duracao": suncitym["duracao"]
        }
      ]
    });
    db.collection("album").doc(menosemais["id"]).update({
      "nome": "Menos É Mais",
      "urlFoto":
          "https://studiosol-a.akamaihd.net/tb/978x978/palcomp3-discografia/7/2/6/f/bb76432b12044faa858ad39010dde327.jpg",
      "lancamento": Timestamp.fromDate(DateTime(2018)),
      "artista_id": hej.id,
      "artista_nome": hej.nome,
      "musica": [
        {
          "id": trescoracoes["id"],
          "nome": trescoracoes["nome"],
          "duracao": trescoracoes["duracao"]
        },
        {
          "id": vaiquebebereis["id"],
          "nome": vaiquebebereis["nome"],
          "duracao": vaiquebebereis["duracao"]
        }
      ]
    });

    //------------------------
    //musicas
    db.collection("musica").doc(trescoracoes["id"]).update({
      "nome": "Três Corações",
      "duracao": "2:41",
      "genero": "Sertanejo",
      "album_id": menosemais["id"],
      "album_nome": menosemais["nome"],
      "album_urlFoto": menosemais["urlFoto"],
      "artista": [
        {
          "id": hej.id,
          "nome": hej.nome,
          "urlFoto": hej.urlFoto,
        }
      ],
    });
    db.collection("musica").doc(vaiquebebereis["id"]).update({
      "nome": "Vai que Bebereis",
      "duracao": "2:41",
      "genero": "Sertanejo",
      "album_id": menosemais["id"],
      "album_nome": menosemais["nome"],
      "album_urlFoto": menosemais["urlFoto"],
      "artista": [
        {
          "id": hej.id,
          "nome": hej.nome,
          "urlFoto": hej.urlFoto,
        }
      ],
    });
    db.collection("musica").doc(godsplan["id"]).update({
      "nome": "God's Plan",
      "duracao": "3:19",
      "genero": "Pop",
      "album_id": scorpion["id"],
      "album_nome": scorpion["nome"],
      "album_urlFoto": scorpion["urlFoto"],
      "artista": [
        {
          "id": drake.id,
          "nome": drake.nome,
          "urlFoto": drake.urlFoto,
        }
      ],
    });
    db.collection("musica").doc(hotlineBling["id"]).update({
      "nome": "Hotline Bling",
      "duracao": "4:27",
      "genero": "Pop",
      "album_id": views["id"],
      "album_nome": views["nome"],
      "album_urlFoto": views["urlFoto"],
      "artista": [
        {
          "id": drake.id,
          "nome": drake.nome,
          "urlFoto": drake.urlFoto,
        }
      ],
    });
    db.collection("musica").doc(oneDance["id"]).update({
      "nome": "One Dance",
      "duracao": "2:54",
      "genero": "Pop",
      "album_id": views["id"],
      "album_nome": views["nome"],
      "album_urlFoto": views["urlFoto"],
      "artista": [
        {
          "id": drake.id,
          "nome": drake.nome,
          "urlFoto": drake.urlFoto,
        }
      ],
    });
    db.collection("musica").doc(suncitym["id"]).update({
      "nome": "Suncity",
      "duracao": "2:54",
      "genero": "Pop",
      "album_id": suncity["id"],
      "album_nome": suncity["nome"],
      "album_urlFoto": suncity["urlFoto"],
      "artista": [
        {
          "id": khalid.id,
          "nome": khalid.nome,
          "urlFoto": khalid.urlFoto,
        }
      ],
    });

    //playlist
    db.collection("playlist").doc(playlist1["id"]).update({
      "nome": "Playlist 1",
      "urlFoto":
          "https://www.mundopositivo.com.br/wp-content/uploads/2019/07/descubra-ouca-a-nova-playlist-do-sua-musica-1.jpeg",
      "autor_id": "nada por enquanto",
      "autor_nome": "Jean",
      "musica": [
        {
          "id": hotlineBling["id"],
          "nome": hotlineBling["nome"],
          "duracao": hotlineBling["duracao"]
        },
        {
          "id": godsplan["id"],
          "nome": godsplan["nome"],
          "duracao": godsplan["duracao"]
        }
      ],
    });
    db.collection("playlist").doc(playlist2["id"]).update({
      "nome": "Playlist 2",
      "urlFoto":
          "https://www.intrinseca.com.br/blog/wp-content/uploads/2016/07/Playlist-Denton.jpg",
      "autor_id": "nada por enquanto",
      "autor_nome": "Jean",
      "musica": [
        {
          "id": hotlineBling["id"],
          "nome": hotlineBling["nome"],
          "duracao": hotlineBling["duracao"]
        },
      ],
    });
  }

  //insercoes no banco
  void insertions() async {
    try {
      db.collection("artista").add({
        "nome": "Drake",
        "urlFoto":
            "https://media-manager.noticiasaominuto.com/1920/naom_5e81db0824292.jpg",
      });
      db.collection("artista").add({
        "nome": "Khalid",
        "urlFoto":
            "https://rollingstone.uol.com.br/media/_versions/legacy/2017/img-1046674-khalid_widelg.jpg",
      });
      db.collection("artista").add({
        "nome": "Rihanna",
        "urlFoto": "https://www.vagalume.com.br/rihanna/images/rihanna.jpg",
      });
      db.collection("artista").add({
        "nome": "Henrique e Juliano",
        "urlFoto":
            "https://e-cdns-images.dzcdn.net/images/artist/439d0e35b1c2269ede25e3f30aae8f4c/500x500.jpg",
      });

      //albuns
      db.collection("album").doc().set({
        "nome": "Views",
        "urlFoto": "https://zh.rbsdirect.com.br/imagesrc/19193089.jpg?w=700",
        "lancamento": Timestamp.fromDate(DateTime(2017)),
        "artista_id": "id",
        "artista_nome": "Drake",
        "musica": [
          {"id": "id", "nome": "Hotline Bling", "duracao": "3:09"}
        ]
      });
      db.collection("album").doc().set({
        "nome": "Scorpion",
        "urlFoto":
            "https://upload.wikimedia.org/wikipedia/pt/c/c2/Scorpion_Drake.jpg",
        "lancamento": Timestamp.fromDate(DateTime(2018)),
        "artista_id": "id",
        "artista_nome": "Drake",
        "musica": [
          {"id": "id", "nome": "God's Plan", "duracao": "3:09"}
        ]
      });
      db.collection("album").doc().set({
        "nome": "Suncity",
        "urlFoto":
            "https://images.genius.com/48ca10fe4ca2ae201fa0b0437c13d72c.1000x1000x1.jpg",
        "lancamento": Timestamp.fromDate(DateTime(2016)),
        "artista_id": "id",
        "artista_nome": "Khalid",
        "musica": [
          {"id": "id", "nome": "Suncity", "duracao": "3:09"}
        ]
      });
      db.collection("album").doc().set({
        "nome": "Anti Deluxe",
        "urlFoto":
            "https://img.discogs.com/1N4c7Yba0bblMS46XyOk4cUI-hs=/fit-in/600x494/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-8393847-1460755973-3600.jpeg.jpg",
        "lancamento": Timestamp.fromDate(DateTime(2017, 9)),
        "artista_id": "id",
        "artista_nome": "Rihanna",
        "musica": [
          {"id": "id", "nome": "Suncity", "duracao": "3:09"}
        ]
      });

      db.collection("album").doc().set({
        "nome": "Menos É Mais",
        "urlFoto":
            "https://studiosol-a.akamaihd.net/tb/978x978/palcomp3-discografia/7/2/6/f/bb76432b12044faa858ad39010dde327.jpg",
        "lancamento": Timestamp.fromDate(DateTime(2018)),
        "artista_id": "id",
        "artista_nome": "Henrique e Juliano",
        "musica": [
          {"id": "id", "nome": "Três Corações", "duracao": "2:41"},
          {"id": "id", "nome": "Vai que Bebereis", "duracao": "2:41"}
        ]
      });
      //musicas
      db.collection("musica").doc().set({
        "nome": "Três Corações",
        "duracao": "2:41",
        "genero": "Sertanejo",
        "album_id": "id",
        "album_nome": "Menos É Mais",
        "album_urlFoto":
            "https://studiosol-a.akamaihd.net/tb/978x978/palcomp3-discografia/7/2/6/f/bb76432b12044faa858ad39010dde327.jpg",
        "artista": [
          {
            "id": "id",
            "nome": "Henrique e Juliano",
            "urlFoto":
                "https://lh3.googleusercontent.com/proxy/aOvgu3mD-HICwaOyHp6i5M44uk2MLCT31PIWm6GgbTVO_OpZtsW2l20rIjaipzHphxK2kUION9CTvVNGHSk5XjV4gIDNxKf2EKtSkxbsa7Pp4lnEzReXfH8uH-xQyBcZWCR-NDcM74kpE5LMOlRXVkWsANcDqPn067qNgPt6O_us"
          }
        ],
      });
      db.collection("musica").doc().set({
        "nome": "Vai que Bebereis",
        "duracao": "2:41",
        "genero": "Sertanejo",
        "album_id": "id",
        "album_nome": "Menos É Mais",
        "album_urlFoto":
            "https://studiosol-a.akamaihd.net/tb/978x978/palcomp3-discografia/7/2/6/f/bb76432b12044faa858ad39010dde327.jpg",
        "artista": [
          {
            "id": "id",
            "nome": "Henrique e Juliano",
            "urlFoto":
                "https://lh3.googleusercontent.com/proxy/aOvgu3mD-HICwaOyHp6i5M44uk2MLCT31PIWm6GgbTVO_OpZtsW2l20rIjaipzHphxK2kUION9CTvVNGHSk5XjV4gIDNxKf2EKtSkxbsa7Pp4lnEzReXfH8uH-xQyBcZWCR-NDcM74kpE5LMOlRXVkWsANcDqPn067qNgPt6O_us"
          }
        ],
      });

      db.collection("musica").doc().set({
        "nome": "God's Plan",
        "duracao": "3:19",
        "genero": "Pop",
        "album_id": "id",
        "album_nome": "Scorpion",
        "album_urlFoto":
            "https://upload.wikimedia.org/wikipedia/pt/c/c2/Scorpion_Drake.jpg",
        "artista": [
          {
            "id": "id",
            "nome": "Drake",
            "urlFoto":
                "https://media-manager.noticiasaominuto.com/1920/naom_5e81db0824292.jpg"
          }
        ],
      });
      db.collection("musica").doc().set({
        "nome": "Hotline Bling",
        "duracao": "4:27",
        "genero": "Pop",
        "album_id": "id",
        "album_nome": "Views",
        "album_urlFoto":
            "https://media-manager.noticiasaominuto.com/1920/naom_5e81db0824292.jpg",
        "artista": [
          {
            "id": "id",
            "nome": "Drake",
            "urlFoto":
                "https://media-manager.noticiasaominuto.com/1920/naom_5e81db0824292.jpg"
          }
        ],
      });
      db.collection("musica").doc().set({
        "nome": "One Dance",
        "duracao": "2:54",
        "genero": "Pop",
        "album_id": "id",
        "album_nome": "Views",
        "album_urlFoto":
            "https://upload.wikimedia.org/wikipedia/pt/c/c2/Scorpion_Drake.jpg",
        "artista": [
          {
            "id": "id",
            "nome": "Drake",
            "urlFoto":
                "https://media-manager.noticiasaominuto.com/1920/naom_5e81db0824292.jpg"
          }
        ],
      });
      db.collection("musica").doc().set({
        "nome": "Suncity",
        "duracao": "2:54",
        "genero": "Pop",
        "album_id": "id",
        "album_nome": "Suncity",
        "album_urlFoto":
            "https://upload.wikimedia.org/wikipedia/pt/c/c2/Scorpion_Drake.jpg",
        "artista": [
          {
            "id": "id",
            "nome": "Khalid",
            "urlFoto":
                "https://media-manager.noticiasaominuto.com/1920/naom_5e81db0824292.jpg"
          }
        ],
      });
      //playlist
      db.collection("playlist").doc().set({
        "nome": "Playlist 1",
        "urlFoto":
            "https://upload.wikimedia.org/wikipedia/pt/c/c2/Scorpion_Drake.jpg",
        "autor_id": "",
        "autor_nome": "Jean",
        "musica": [
          {"id": "", "nome": "Hotline Bling", "duracao": "3:09"},
          {"id": "", "nome": "God's Plan", "duracao": "4:02"}
        ],
      });
      db.collection("playlist").doc().set({
        "nome": "Playlist 2",
        "urlFoto":
            "https://media-manager.noticiasaominuto.com/1920/naom_5e81db0824292.jpg",
        "autor_id": "",
        "autor_nome": "Jean",
        "musica": [
          {"id": "", "nome": "Hotline Bling", "duracao": "3:09"},
        ],
      });
    } catch (e) {
      return e;
    }
  }
}
