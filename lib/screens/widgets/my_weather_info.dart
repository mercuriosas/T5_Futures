import 'package:flutter/material.dart';
import '../../repository/repository_weather.dart';


// TO-DO 7b: Converteix la classe en StateFull,
// (es pot fer amb les ajudes de codi, amb Ctrl+"." damunt el nom de classe)
// i defineix dins l'estat una propietat (dynamic)
// que contindrà la informació futura amb l'oratge.
// Després inicialitza l'estat (initState), de manera que
// obtinga aquesta informació de forma asíncrona 
// a través del mètode obteClima del repositori corresponent.
// Tingueu en compte que aquest mètode requereix de latitud
// i longitud, i que aquestes propietats s'ho troben al widget
// (és a dir, cal accedir a widget.latitud, etc.)

class MyWeatherInfo extends StatefulWidget {

  // TO-DO 7a: Incorpora les propietats latitud i longitud 
  // a aquesta classe (com a Double) i modifica el 
  // constructor per a que les reba com a arguments amb nom

  const MyWeatherInfo({
    super.key,
    required this.longitud,
    required this.latitud
  });

  final double? longitud;
  final double? latitud;

  @override
  State<MyWeatherInfo> createState() => _MyWeatherInfoState();
}

class _MyWeatherInfoState extends State<MyWeatherInfo> {
  late Future<dynamic> infoWeather;

  @override
  void initState() {
    super.initState();
    infoWeather = RepositoryWeather.obteClima(
        longitud: widget.longitud!, latitud: widget.latitud!);
  }

  @override
  Widget build(BuildContext context) {
    // TO-DO 7c: Modifica la construcció d'aquest giny
    // fent ús d'un FutureBuilder, de manera que quan la
    // informació estiga disponible el genere amb les 
    // dades obtingudes.

    return FutureBuilder(
        future: infoWeather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String temperatura =
            snapshot.data["current_weather"]["temperature"].toString();
            String velocVent =
            snapshot.data["current_weather"]["windspeed"].toString();
            String direccioVent =
            snapshot.data["current_weather"]["winddirection"].toString();
            String codi =
            snapshot.data["current_weather"]["weathercode"].toString();
            return Column(
              children: [
                _obtenirIconaOratge(codi),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.thermostat,size: 35,),
                    Text(temperatura,style: Theme.of(context).textTheme.headlineMedium,),
                  ],),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wind_power, size: 30),
                    const SizedBox(width: 25),
                    Text(velocVent,style: Theme.of(context).textTheme.headlineSmall,),
                    const SizedBox(width: 25),
                    obteGinyDireccioVent(direccioVent, context),
                  ],
                ),],
            );
          }else {
            return const CircularProgressIndicator();
          }
        });
  }


        Widget obteGinyDireccioVent(String direccioVent, BuildContext context)
    {
      double dir = double.parse(direccioVent);
      late Icon icona;

      late String nomVent;

      if (dir > 22.5 && dir < 65.5) {
        icona = const Icon(Icons.north_east);
        nomVent = "Gregal";
      } else if (dir > 67.5 && dir < 112.5) {
        icona = const Icon(Icons.east);
        nomVent = "Llevant";
      } else if (dir > 112.5 && dir < 157.5) {
        icona = const Icon(Icons.south_east);
        nomVent = "Xaloc";
      } else if (dir > 157.5 && dir < 202.5) {
        icona = const Icon(Icons.south);
        nomVent = "Migjorn";
      } else if (dir > 202.5 && dir < 247.5) {
        icona = const Icon(Icons.south_west);
        nomVent = "Llebeig/Garbí";
      } else if (dir > 247.5 && dir < 292.5) {
        icona = const Icon(Icons.west);
        nomVent = "Ponent";
      } else if (dir > 292.5 && dir < 337.5) {
        icona = const Icon(Icons.north_west);
        nomVent = "Mestral";
      } else {
        icona = const Icon(Icons.north);
        nomVent = "Tramuntana";
      }
      return Row(children: [
        Text(
          nomVent,
          style: Theme
              .of(context)
              .textTheme
              .headlineSmall,
        ),
        icona,
      ]);
    }

    // Codis de https://open-meteo.com/en/docs/dwd-api

    Widget _obtenirIconaOratge(String value) {
      Set<String> sol = <String>{"0"};
      Set<String> pocsNuvols = <String>{"1", "2", "3"};
      Set<String> nuvols = <String>{"45", "48"};
      Set<String> plujasuau = <String>{"51", "53", "55"};
      Set<String> pluja = <String>{
        "61",
        "63",
        "65",
        "66",
        "67",
        "80",
        "81",
        "82",
        "95",
        "96",
        "99"
      };
      Set<String> neu = <String>{"71", "73", "75", "77", "85", "86"};

      if (sol.contains(value)) {
        return Image.asset("assets/icons/png/soleado.png");
      }
      if (pocsNuvols.contains(value)) {
        return Image.asset("assets/icons/png/poco_nublado.png");
      }
      if (nuvols.contains(value)) {
        return Image.asset("assets/icons/png/nublado.png");
      }
      if (plujasuau.contains(value)) {
        return Image.asset("assets/icons/png/lluvia_debil.png");
      }
      if (pluja.contains(value)) {
        return Image.asset("assets/icons/png/lluvia.png");
      }
      if (neu.contains(value)) {
        return Image.asset("assets/icons/png/nieve.png");
      }

      return Image.asset("assets/icons/png/poco_nublado.png");
    }
  }
