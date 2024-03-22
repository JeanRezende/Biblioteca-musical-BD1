import 'package:bibliMusical/controller/database.dart';
import 'package:bibliMusical/model/Musica.dart';
import 'package:flutter/material.dart';

class MusicasGenero extends StatefulWidget {
  String _id;
  MusicasGenero(this._id);

  get id => _id;

  @override
  _MusicasGeneroState createState() => _MusicasGeneroState(id);
}

class _MusicasGeneroState extends State<MusicasGenero> {
  String _id;
  _MusicasGeneroState(this._id);

  @override
  Widget build(BuildContext context) {
    //print(_id);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Genero"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_id,
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
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
      child: FutureBuilder<List<Musica>>(
          future: DBHelper().buscaGeneroMusica(id),
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
                      separatorBuilder: (context, index) => Divider(
                            height: 4,
                            color: Colors.grey,
                          ),
                      primary: false,
                      //scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              child: Icon(
                                Icons.play_circle_fill,
                                size: 40,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              //color: Colors.green,
                              height: MediaQuery.of(context).size.height / 13,
                              width: MediaQuery.of(context).size.width / 1.3,
                              padding: const EdgeInsets.only(left: 8),
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
                                    snapshot.data[index].artista[index]["nome"],
                                    //snapshot.data[index].idArtista,
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
                            GestureDetector(
                              child: Icon(Icons.more_horiz,
                                  size: 20, color: Colors.white),
                            ),
                          ],
                        ));
                      });
                }
            }
            return ListView();
          }));
}
