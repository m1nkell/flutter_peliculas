import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';


class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;
  final Function siguientePagina;

  //

  final _pageController = new PageController(
      initialPage: 1,
      viewportFraction: 0.3,
  );

  //instanciar
  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  @override
  Widget build(BuildContext context) {

    //medir la dimension del dispositivo

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener( () {

      if( _pageController.position.pixels >= _pageController.position.maxScrollExtent -200 ){

        siguientePagina();

      }

    });

    return Container(
        height: _screenSize.height * 0.25,
        child: PageView.builder(
          controller: _pageController,
          pageSnapping: false,
          itemCount: peliculas.length,
          itemBuilder: (context, i){
              return _tarjeta(context, peliculas[i]);
          },
        ),
    );
  }


  Widget _tarjeta(BuildContext context, Pelicula pelicula){

    final tarjeta = Container(
            margin: EdgeInsets.only(right: 15.0),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                    image: NetworkImage( pelicula.getPosterImg() ),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    //para agarrar todo el ancho del dispositivo
                    fit: BoxFit.fill,
                    height: 160.0,
                  ),
                ),
                Text(
                  pelicula.title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ],
            ),
          );

    return GestureDetector(

      child: tarjeta,
      onTap: (){

        Navigator.pushNamed(context, 'detalles', arguments: pelicula);

      },

    );

  }

  List<Widget> _tarjetas(context) {

    return peliculas.map((pelicula){

      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage( pelicula.getPosterImg() ),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                //para agarrar todo el ancho del dispositivo
                fit: BoxFit.fill,
                height: 160.0,
              ),
            ),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle,
            ),
          ],
        ),
      );

    }).toList();

  }

}