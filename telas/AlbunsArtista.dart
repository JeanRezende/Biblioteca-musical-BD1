import 'package:bibliMusical/controller/database.dart';
import 'package:bibliMusical/model/Album.dart';
import 'package:flutter/material.dart';
import 'package:bibliMusical/controller/database.dart';

// ignore: must_be_immutable
class AlbunsArtista extends StatefulWidget {
  String _id;
  AlbunsArtista(this._id);

  get id => _id;

  @override
  _AlbunsArtistaState createState() => _AlbunsArtistaState(id);
}

class _AlbunsArtistaState extends State<AlbunsArtista> {
  String _id;
  _AlbunsArtistaState(this._id);

  @override
  Widget build(BuildContext context) {
    //print(_id);
    return Scaffold(
      appBar: AppBar(
        title: Text("Artista"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20.0),
            buildPlaylist(context, _id),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}

buildPlaylist(BuildContext _, String id) {
  return Container(
      height: MediaQuery.of(_).size.height,
      width: MediaQuery.of(_).size.width,
      child: FutureBuilder<List<Album>>(
          future: DBHelper().buscaAlbumArtista(id),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                CircularProgressIndicator();
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                //print("conexao feita");
                if (snapshot.hasError) {
                  print("erro");
                } else {
                  return ListView.separated(
                      separatorBuilder: (_, index) => Divider(
                            height: 4,
                            color: Colors.grey,
                          ),
                      primary: false,
                      //scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.network(
                                snapshot.data[index].urlFoto,
                                height: MediaQuery.of(_).size.height / 6,
                                width: MediaQuery.of(_).size.height / 6,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                height: MediaQuery.of(_).size.height / 6,
                                width: MediaQuery.of(_).size.height / 3,
                                padding: const EdgeInsets.all(8),
                                constraints: BoxConstraints(
                                  minWidth: 20,
                                  minHeight: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data[index].nome,
                                      //artista.nome,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "Descrição geral da playlist Lorem ipsum", //snapshot.data[index]["nome"],
                                      //artista.nome,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ));
                      });
                }
            }
            return ListView();
          }));
}
