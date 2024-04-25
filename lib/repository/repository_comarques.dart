import 'package:comarquesgui/models/comarca.dart';
import 'package:comarquesgui/models/provincia.dart';
import 'package:comarquesgui/services/comarques_service.dart';

class RepositoryComarques {
  static Future<List<Provincia>> obtenirProvincies()  {
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
    Future <List<dynamic>> comarques;
    comarques = ComarquesService.obtenirComarques(provincia);
    return comarques;

    //return Future.value([]); // Caldrà eliminar este return
  }

  static Future<Comarca?> obtenirInfoComarca(String comarca) {
    // TO-DO 3

    // Retorna la informació completa de la comarca sol·licitada, 
    // fent ús del mètode infoComarca de la classe sel servei de Comarques.
    Future<Comarca?> infocomar;
    infocomar = ComarquesService.infoComarca(comarca);
    return infocomar;
    //return Future.value(null); // Caldrà eliminar este return

  }
}
