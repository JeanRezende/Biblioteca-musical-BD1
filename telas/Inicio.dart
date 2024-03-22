import 'package:bibliMusical/controller/database.dart';
import 'package:bibliMusical/model/Artista.dart';
import 'package:bibliMusical/model/Playlist_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bibliMusical/controller/SearchBar.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: buildSearchBar(context),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20.0),
            buildCategoryRow('Trending Playlists', context),
            SizedBox(height: 10.0),
            buildTrendingList(context),
            SizedBox(height: 10.0),
            buildCategoryRow('Generos', context),
            SizedBox(height: 10.0),
            buildGenreList(context),
            SizedBox(height: 20.0),
            buildCategoryRow('Artistas', context),
            SizedBox(height: 10.0),
            buildArtistList(context),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }

  buildCategoryRow(String category, BuildContext context) {
    //nome da categoria
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "$category",
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w800, color: Colors.white),
        )
        /*
        FlatButton(
          child: Text(
            "See all (9)",
            style: TextStyle(
              color: Theme.of(context).accentColor,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return; // mudar
                },
              ), 
            );
          },
        ),*/
      ],
    );
  }

  buildGenreList(BuildContext context) {
    //lista de generos musicais
    return Container(
        height: MediaQuery.of(context).size.height / 6,
        width: MediaQuery.of(context).size.width / 2,
        child: FutureBuilder<List<String>>(
            future: DBHelper().buscaGenero(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  CircularProgressIndicator();
                  break;
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    print("erro");
                  } else {
                    return ListView.builder(
                        primary: false,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/MusicasGenero",
                                    arguments: snapshot.data[index]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Stack(
                                    children: <Widget>[
                                      Image.network(
                                        "https://img.freepik.com/vetores-gratis/fundo-quadrinho-azul-com-linhas-e-meio-tom_1017-11432.jpg?size=338&ext=jpg",
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        width:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            // Add one stop for each color. Stops should increase from 0 to 1
                                            stops: [0.2, 0.7],
                                            colors: [
                                              Colors.black26,
                                              Colors.black87
                                            ],
                                            // stops: [0.0, 0.1],
                                          ),
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        width:
                                            MediaQuery.of(context).size.height /
                                                6,
                                      ),
                                      Center(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6,
                                          padding: const EdgeInsets.all(1),
                                          constraints: BoxConstraints(
                                            minWidth: 20,
                                            minHeight: 20,
                                          ),
                                          child: Center(
                                            child: Text(
                                              snapshot.data[index],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
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

  buildSearchBar(BuildContext context) {
    return PreferredSize(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0),
        child: SearchCard(),
      ),
      preferredSize: Size(
        MediaQuery.of(context).size.width,
        60.0,
      ),
    );
  }

  buildTrendingList(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 6,
        width: MediaQuery.of(context).size.width / 2,
        child: FutureBuilder<List<Playlist_model>>(
            future: DBHelper().buscaPlaylist(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  CircularProgressIndicator();
                  break;
                case ConnectionState.active:
                case ConnectionState.done:
                  //print("dados recebidos " + snapshot.data.toString());
                  // if (snapshot.hasError) {
                  //   print("erro");
                  // } else {
                  return ListView.builder(
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/Playlist",
                                  arguments: snapshot.data[index].id);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Stack(
                                  children: <Widget>[
                                    Image.network(
                                      snapshot.data[index].urlFoto,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              6,
                                      width:
                                          MediaQuery.of(context).size.height /
                                              6,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          // Add one stop for each color. Stops should increase from 0 to 1
                                          stops: [0.2, 0.7],
                                          colors: [
                                            Colors.black26,
                                            Colors.black87
                                          ],
                                          // stops: [0.0, 0.1],
                                        ),
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              6,
                                      width:
                                          MediaQuery.of(context).size.height /
                                              6,
                                    ),
                                    Center(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        width:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        padding: const EdgeInsets.all(1),
                                        constraints: BoxConstraints(
                                          minWidth: 20,
                                          minHeight: 20,
                                        ),
                                        child: Center(
                                          child: Text(
                                            snapshot.data[index].nome,
                                            //artista.nome,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      });
              }
              // }
              return ListView();
            }));
  }

  buildArtistList(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 6,
        width: MediaQuery.of(context).size.width / 2,
        child: FutureBuilder<List<Artista>>(
            future: DBHelper().buscaArtista(), //_carregaritens(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  CircularProgressIndicator();
                  break;
                case ConnectionState.active:
                case ConnectionState.done:
                  //print("conexao feita");
                  if (snapshot.hasError) {
                    print("erro");
                  } else {
                    return ListView.builder(
                        primary: false,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/AlbunsArtista",
                                    arguments: snapshot.data[index].id);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Stack(
                                    children: <Widget>[
                                      Image.network(
                                        snapshot.data[index].urlFoto,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        width:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            // Add one stop for each color. Stops should increase from 0 to 1
                                            stops: [0.2, 0.7],
                                            colors: [
                                              Colors.black26,
                                              Colors.black87
                                            ],
                                            // stops: [0.0, 0.1],
                                          ),
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        width:
                                            MediaQuery.of(context).size.height /
                                                6,
                                      ),
                                      Center(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6,
                                          padding: const EdgeInsets.all(1),
                                          constraints: BoxConstraints(
                                            minWidth: 20,
                                            minHeight: 20,
                                          ),
                                          child: Center(
                                            child: Text(
                                              snapshot.data[index].nome,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
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
