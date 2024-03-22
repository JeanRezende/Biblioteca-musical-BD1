import 'package:bibliMusical/Home.dart';
import 'package:bibliMusical/telas/AlbunsArtista.dart';
import 'package:bibliMusical/telas/Biblioteca.dart';
import 'package:bibliMusical/telas/Inicio.dart';
import 'package:bibliMusical/telas/MusicasGenero.dart';
import 'package:bibliMusical/telas/Perfil.dart';
import 'package:bibliMusical/telas/Playlist.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => Home()); // _ no lugar de context nao ocupa memoria
      case "/Inicio":
        return MaterialPageRoute(builder: (_) => Inicio());
      case "/Biblioteca":
        return MaterialPageRoute(builder: (_) => Biblioteca());
      case "/Perfil":
        return MaterialPageRoute(builder: (_) => Perfil());
      case "/Playlist":
        return MaterialPageRoute(builder: (_) => Playlist(arguments));
      case "/MusicasGenero":
        return MaterialPageRoute(builder: (_) => MusicasGenero(arguments));
      case "/AlbunsArtista":
        return MaterialPageRoute(builder: (_) => AlbunsArtista(arguments));
        defaut:
        _erroRota();
    }
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Tela nao encontrada"),
        ),
        body: Center(
          child: Text("Tela nao encontrada"),
        ),
      );
    });
  }
}
