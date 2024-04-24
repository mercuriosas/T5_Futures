import 'dart:ffi';

import 'package:comarquesgui/models/comarca.dart';
import 'package:comarquesgui/models/provincia.dart';
import 'package:comarquesgui/services/comarques_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RepositoryComarques {
  static Future<List<Provincia>> obtenirProvincies() {
    // Retorna una llista de provincies, obtingudes a partir de la
    // funcionalitat proporcionada per l'API
    return ComarquesService.obtenirProvincies();
  }

  static Future<List<dynamic>> obtenirComarques(String provincia) {
    // TO-DO 2

    // Retorna una llista d'objectes dinàmics amb el nom i la imatge
    // de cada comarca de la província indicada. Per a això fa ús de
    // la funcionalitat proporcionada al mètode obtenirComarques del
    // servei de ComarquesService.

    @override
    Widget build(BuildContext context) {
      return Center(
        child: FutureBuilder(
          future: obtenirComarques(provincia),
          initialData: "Esperant resposta...",
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data);
            }
            else {
              return const CircularProgressIndicator();
            }
          },
        ),
      );
    }
//He dejado este return porque daba error. Revisar más adelante
      //return Future.value([]); // Caldrà eliminar este return
    return Future.value();
  }


  static Future<Comarca?> infoComarca(String comarca) {
    // TO-DO 3

    // Retorna la informació completa de la comarca sol·licitada, 
    // fent ús del mètode infoComarca de la classe sel servei de Comarques.

    @override
    Widget build(BuildContext context) {
      return Center(
        child:FutureBuilder(
          future: infoComarca(comarca),
          initialData: "Esperant resposta...",
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              return Text(snapshot.data);
            }
            else{
              return const CircularProgressIndicator();
            }
          },
        ),
      );
    }

    //return Future.value(); // Caldrà eliminar este return
    return Future.value();
  }

}
//

