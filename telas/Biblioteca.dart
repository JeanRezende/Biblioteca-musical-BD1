import 'package:bibliMusical/model/Playlist_model.dart';
import 'package:flutter/material.dart';
import 'package:bibliMusical/controller/database.dart';

class Biblioteca extends StatefulWidget {
  @override
  _BibliotecaState createState() => _BibliotecaState();
}

class _BibliotecaState extends State<Biblioteca> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20.0),
            buildPlaylistList(context),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  buildPlaylistList(BuildContext context) {
    return Container(
        //color: Colors.black,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<List<Playlist_model>>(
            future: DBHelper().buscaPlaylist(), //_carregaritens(),
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
                    return ListView.builder(
                        primary: false,
                        //scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.network(
                                    snapshot.data[index].urlFoto,
                                    height:
                                        MediaQuery.of(context).size.height / 6,
                                    width:
                                        MediaQuery.of(context).size.height / 6,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 6,
                                    width:
                                        MediaQuery.of(context).size.height / 3,
                                    padding: const EdgeInsets.all(8),
                                    constraints: BoxConstraints(
                                      minWidth: 20,
                                      minHeight: 20,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data[index].nome,
                                          //artista.nome,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          "Descrição geral da playlist", //snapshot.data[index]["nome"],
                                          //artista.nome,
                                          style: TextStyle(
                                            color: Colors.white,
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
                            ),
                          ));
                        });
                  }
              }
              return ListView();
            }));
  }
}
