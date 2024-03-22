import 'package:bibliMusical/telas/Perfil.dart';
import 'package:flutter/material.dart';
import 'package:bibliMusical/telas/Biblioteca.dart';
import 'package:bibliMusical/telas/Inicio.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _indiceAtual = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> telas = [Inicio(), Biblioteca(), Perfil()];

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Container(
        //color: Colors.grey,
        padding: EdgeInsets.all(8),
        child: telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black87,
          currentIndex: _indiceAtual,
          onTap: (indice) {
            setState(() {
              _indiceAtual = indice;
              //DBHelper().insertions();
              //DBHelper().updates();
            });
          },
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.green,
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
                //backgroundColor: Colors.orange,
                label: ("inicio"),
                icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                //backgroundColor: Colors.blue,
                label: ("Suas Playlists"),
                icon: Icon(Icons.subscriptions)),
            BottomNavigationBarItem(
                //backgroundColor: Colors.green,
                label: ("Perfil"),
                icon: Icon(Icons.person)),
          ]),
    );
  }
}
