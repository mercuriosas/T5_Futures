import 'package:comarquesgui/models/comarca.dart';
import 'package:comarquesgui/screens/infocomarca_detall.dart';
import 'package:comarquesgui/screens/infocomarca_general.dart';
import 'package:flutter/material.dart';

import '../repository/repository_comarques.dart';

class InfoComarcaScreen extends StatefulWidget {
  // Recordeu que: Per mantindre el const, cal definir la propietat amb el
  // nom de la comarca com a final.
  // A més, aquesta propietat s'ha d'inicialitzar en el constructor.

  const InfoComarcaScreen({super.key, required this.nomComarca});

  final String nomComarca;

  @override
  State<InfoComarcaScreen> createState() => _InfoComarcaScreenState();
}

class _InfoComarcaScreenState extends State<InfoComarcaScreen> {
  // Definim la comarca

  // TO-DO 5b: Modifica la declaració de comarca, per a que
  //           agafe un Future, i per a que es puga assignar 
  //           el seu valor més tard.
  late Future<dynamic> comarcaInfo;

  // Definim l'índex de la pantalla actual
  int indexPantallaActual = 0;

  @override
  void initState() {
    super.initState();
    // Ara RepositoryExample ja no existeix // comarca = RepositoryExemple.obtenirInfoComarca(widget.nomComarca);

    // TO-DO 5a: Obtenir la informació de la comarca
    //           a través del repositori corresponent.
    comarcaInfo = RepositoryComarques.obtenirInfoComarca(widget.nomComarca!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: [
        const Text("Informació General",
            style: TextStyle(
              fontFamily: "LeckerliOne",
              fontSize: 30,
            )),
        const Text("Població i oratge",
            style: TextStyle(
              fontFamily: "LeckerliOne",
              fontSize: 30,
            ))
      ][indexPantallaActual]),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            indexPantallaActual = index;
          });
        },
        selectedIndex: indexPantallaActual,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info),
            label: 'Informació general',
          ),
          NavigationDestination(
            icon: Icon(Icons.wb_sunny_outlined),
            selectedIcon: Icon(Icons.sunny),
            label: 'Informació detallada',
          ),
        ],
      ),
      body: <Widget>[
        // Proporcoinem a estos widgets la comarca en qüestió

        // TO-DO 6: Modifica la creació d'estos widgets,
        // de manera que es construisquen mitjançant un  FutureBuilder.
        // Mentre no es resolga la informació es mostrarà un indicador
        // de progrés.

        //InfoComarcaGeneral(comarca: comarca), // A modificar per la info que rebem a l'snapshot quan es resol el Future
        //InfoComarcaDetall(comarca: comarca)   // A modificar per la info que rebem a l'snapshot quan es resol el Future
        Container(
          alignment: Alignment.center,
          child: FutureBuilder(
            future: comarcaInfo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return InfoComarcaGeneral(nomcomarca: widget.nomComarca!, comarca: snapshot.data);
              } else {
                return const Center(
                  child: SizedBox(
                      width: 200,height: 200,
                      child: CircularProgressIndicator()),
                );
              }
            },),
        ),
        Container(
          alignment: Alignment.center,
          child: FutureBuilder(
            future: comarcaInfo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return InfoComarcaDetall(nomcomarca: widget.nomComarca!, comarca: snapshot.data);
              } else {
                return const Center(
                  child: SizedBox(
                      width: 200,height: 200,
                      child: CircularProgressIndicator()),
                );
              }
            },),
        ),
      ][indexPantallaActual],
    );
  }
}
