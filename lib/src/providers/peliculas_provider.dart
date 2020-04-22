import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/pelicula_model.dart';
import 'dart:async';
class Peliculasprovider {

  String _apikey  =  '05efe4aacef1d1ff1459e88a69139a3a';
  String _url     =  'api.themoviedb.org';
  String _language =  'es-ES';

  int _popularesPage = 0;

  bool _cargando = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams(){
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> getEnCines() async {

    final url = Uri.http(_url,'3/movie/now_playing', {
      'api_key'   : _apikey,
      'language'  : _language
    });

    return await getElementos(url);

  }

  Future<List<Pelicula>> getPopular() async {

    if( _cargando ) return [];

    _cargando = true;
    _popularesPage++;

    final url = Uri.http(_url,'3/movie/popular', {
      'api_key'   : _apikey,
      'language'  : _language,
      'page'      : _popularesPage.toString()
    });

    final resp = await getElementos(url);

    _populares.addAll(resp);
    popularesSink( _populares );

    return resp;

  }

  Future getElementos(url) async {

    final rsp = await http.get(url); //se traen los datos desde la pagina
    final decodeData = jsonDecode(rsp.body); //convertir a un map
    final peliculas = new Peliculas.fromJsonList(decodeData['results']);

    _cargando = false;

    return peliculas.items;

  }


}