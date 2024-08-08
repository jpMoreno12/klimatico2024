//import 'package:flutter/material.dart';
//import 'package:klmatico/models/weather.dart';
//import 'package:klmatico/telas/tela_cidade.dart';
//import 'package:klmatico/transacoes/pega_clima.dart';
//import 'package:klmatico/util/util.dart' as util;
//
//
//class Klimatico extends StatefulWidget {
//  const Klimatico({super.key});
//
//  @override
//  State<Klimatico> createState() => _KlimaticoState();
//}
//
//class _KlimaticoState extends State<Klimatico> {
//  String  _cidadeIncerida = util.minhaCidade; //Garante que ela tenha um valor padrao
//  Future _abrirNovaTela(BuildContext context) async{
//    final resultado = await Navigator
//      .of(context)
//      .push(MaterialPageRoute<Map<String,dynamic>>(
//
//        builder: (BuildContext context){
//          return MudarCidade();
//
//
//
//        }));
//        if ( resultado != null && resultado.containsKey('cidade')) {
//          _cidadeIncerida = resultado['cidade'];
//        }
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.purple,
//        title: const Text(
//          'Klimatico',
//          style: TextStyle(
//            fontWeight: FontWeight.bold,
//            color: Colors.white,
//          ),
//        ),
//        shape:  const RoundedRectangleBorder(
//          borderRadius: BorderRadius.only(
//            bottomLeft: Radius.circular(40) ,
//            bottomRight: Radius.circular(40),
//          )
//        ),
//        centerTitle: true,
//        actions: [
//          IconButton(onPressed: () => _abrirNovaTela(context), 
//          icon: const Icon(Icons.menu),
//          color: Colors.white,
//          ),
//        ],
//      ),
//      body: Stack(
//        children: [
//          Center(
//            child: Image.asset('assets/umbrella.png',
//            width: double.infinity,
//            height: double.infinity,
//            fit: BoxFit.cover,
//            ),
//          ),
//          Container(
//            alignment: Alignment.topRight,
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: [
//                Text(
//                  _cidadeIncerida ?? util.minhaCidade
//                ),
//              ],
//            ),
//          ),
//          Container(
//            alignment: Alignment.center,
//            child: Image.asset('assets/light_rain.png'),
//          ),
//          atualizarTemWidget(_cidadeIncerida)
//        ],
//      ),
//    );
//  }
//
//  Widget atualizarTemWidget(String cidade) {
//    return FutureBuilder(
//      future: WeatherNetworkService.pegaClima(util.appId, cidade ?? util.minhaCidade) ,
//      builder: (BuildContext context, AsyncSnapshot<Weather> snapshot) {
//        if (snapshot.hasData) {
//          Weather conteudo = snapshot.data!;
//          debugPrint('${conteudo.temperature.toString()} PRINTADO!');
//            return Container(
//              child:  Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: [
//                  ListTile(
//                    title: Text("${conteudo.temperature.toString()}C"),
//                    subtitle:  const ListTile(
//                      title: Text('Humanidade'),
//                    ),
//                  )
//                ],
//              ),
//            );
//        } else {
//          return Container(
//            child: const Text('FAlhou!!!!'),
//          );
//        }
//      } 
//    );
//  }
//}


import 'package:flutter/material.dart';
import 'package:klmatico/models/weather.dart';
import 'package:klmatico/telas/tela_cidade.dart';
import 'package:klmatico/transacoes/pega_clima.dart';
import 'package:klmatico/util/util.dart' as util;

class Klimatico extends StatefulWidget {
  const Klimatico({super.key});

  @override
  State<Klimatico> createState() => _KlimaticoState();
}

class _KlimaticoState extends State<Klimatico> {
  String _cidadeIncerida = 'Digite uma cidade'; // Garante que ela tenha um valor padrão

  Future _abrirNovaTela(BuildContext context) async {
    final resultado = await Navigator.of(context).push(
      MaterialPageRoute<Map<String, dynamic>>(
        builder: (BuildContext context) {
          return MudarCidade();
        },
      ),
    );

    if (resultado != null && resultado.containsKey('cidade')) {
      setState(() {
        _cidadeIncerida = resultado['cidade'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Klimatico',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _abrirNovaTela(context),
            icon: const Icon(Icons.menu),
            color: Colors.white,
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/umbrella.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _cidadeIncerida,
                  style: styleCidade(),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset('assets/light_rain.png'),
          ),
          atualizarTemWidget(_cidadeIncerida),
        ],
      ),
    );
  }

  Widget atualizarTemWidget(String cidade) {
    return FutureBuilder<Weather>(
      future: WeatherNetworkService.pegaClima(util.appId, cidade),
      builder: (BuildContext context, AsyncSnapshot<Weather> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Exibe um indicador de carregamento enquanto espera a resposta
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Exibe uma mensagem de erro se houver um problema com a requisição
          return Center(child: Text('Erro: ${snapshot.error}',
          style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),));
        } else if (snapshot.hasData) {
          // Quando há dados, exibe a temperatura e outras informações
          Weather conteudo = snapshot.data!;
          debugPrint('Temperatura: ${conteudo.temperature.toString()}');
          return Container(
            margin: const EdgeInsets.fromLTRB(30, 350, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(
                    "${conteudo.temperature.toString()}°C",
                    style: const TextStyle(
                      fontSize: 49.9,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: ListTile(
                   title:  Text(
                    "Humidade: ${conteudo.humidity} \n"
                    "Min: ${conteudo.minTemp.toString()} C°\n"
                    "Max: ${conteudo.maxTemp.toString()} C°",
                    style: extraTemp(), 
                    ),
                  ),
                ), 
              ],
            ),
          );
        } else {
          // Exibe uma mensagem padrão se não houver dados
          return const Center(child: Text('Nenhum dado disponível'));
        }
      },
    );
  }
  
  extraTemp() {
    return const TextStyle(
      color:  Colors.white,
      fontStyle: FontStyle.normal,
      fontSize: 19.0,
    );
  }
  
  TextStyle styleCidade() {
    return const TextStyle(
            fontSize: 29.9,
            color: Colors.white,
            fontStyle: FontStyle.italic,
            );
  }
}
