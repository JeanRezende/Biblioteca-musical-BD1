import 'package:bibliMusical/controller/database.dart';
import 'package:bibliMusical/model/Playlist_model.dart';
import 'package:flutter/material.dart';

class Playlist extends StatefulWidget {
  String _id;
  Playlist(this._id);

  get id => _id;

  @override
  _PlaylistState createState() => _PlaylistState(id);
}

class _PlaylistState extends State<Playlist> {
  String _id;
  _PlaylistState(this._id);

  @override
  Widget build(BuildContext context) {
    //DBHelper().insertions();
    //DBHelper().updates();
    //print(_id);
    return Scaffold(
      appBar: AppBar(
        title: Text("Playlist"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
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
      child: FutureBuilder<Playlist_model>(
          future: DBHelper().buscaPlaylistbyId(id),
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
                  return Column(
                    children: [
                      Image.network(
                        snapshot.data.urlFoto,
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.height / 5,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        snapshot.data.nome,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "autor: " + snapshot.data.autorNome,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                                height: 4,
                                color: Colors.grey,
                              ),
                          primary: false,
                          //scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapshot.data.musica.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: MediaQuery.of(context).size.height / 14,
                              width: MediaQuery.of(context).size.width,
                              //color: Colors.green,
                              child: GestureDetector(
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
                                    // height:
                                    //     MediaQuery.of(context).size.height / 13,
                                    width:
                                        MediaQuery.of(context).size.width / 1.3,
                                    padding: const EdgeInsets.all(8),
                                    constraints: BoxConstraints(
                                      minWidth: 20,
                                      minHeight: 20,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data.musica[index]["nome"],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Icon(Icons.more_horiz,
                                        size: 20, color: Colors.black),
                                  ),
                                ],
                              )),
                            );
                          }),
                    ],
                  );
                }
            }
            return ListView();
          }));
}
