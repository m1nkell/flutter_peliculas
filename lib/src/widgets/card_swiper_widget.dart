import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
 // const CardSwiper({Key key}) : super(key: key);

  final List<Pelicula> peliculas;

  CardSwiper({ @required this.peliculas });

  @override
  Widget build(BuildContext context) {
    
    //Informaciones del dispositivo como alto y ancho de la pantalla
    final _screenSize = MediaQuery.of(context).size;

    return Container(

      padding: EdgeInsets.only(top: 10.0),
          child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.5,
          itemBuilder: (BuildContext context,int index){
            return ClipRRect(
              child: FadeInImage(
                image: NetworkImage(
                  peliculas[index].getPosterImg()
                ),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.scaleDown,
              ),
              borderRadius: BorderRadius.circular(20.0),
            );
            
          },
          itemCount: peliculas.length,
        ),
    );


  }
}