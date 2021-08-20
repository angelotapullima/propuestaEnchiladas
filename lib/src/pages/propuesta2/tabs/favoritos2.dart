import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propuesta_enchiladas/src/bloc/provider.dart';
import 'package:propuesta_enchiladas/src/models/productos_model.dart';
import 'package:propuesta_enchiladas/src/utils/responsive.dart';

class Favoritos2 extends StatelessWidget {
  const Favoritos2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productoBloc = ProviderBloc.prod(context);
    productoBloc.obtenerProductosdeliveryEnchiladasPorCategoria('3');

    final responsive = Responsive.of(context);
    return Scaffold(
      backgroundColor: Color(0xE1F0EFEF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Favoritos',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                  fontSize: 19,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: productoBloc.productosEnchiladasStream,
                builder: (BuildContext context, AsyncSnapshot<List<ProductosData>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length > 0) {
                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1,
                          crossAxisCount: 2,
                          mainAxisSpacing: responsive.hp(2),
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return Container(
                            height: responsive.hp(15),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.only(
                              right: responsive.wp(1.5),
                              left: responsive.wp(1.5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      height: responsive.hp(16),
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          progressIndicatorBuilder: (_, url, downloadProgress) {
                                            return Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              child: Stack(
                                                children: [
                                                  Center(
                                                    child: CircularProgressIndicator(
                                                      value: downloadProgress.progress,
                                                      backgroundColor: Colors.green,
                                                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: (downloadProgress.progress != null)
                                                        ? Text('${(downloadProgress.progress * 100).toInt().toString()}%')
                                                        : Container(),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                          errorWidget: (context, url, error) =>
                                              Image(image: AssetImage('assets/carga_fallida.jpg'), fit: BoxFit.cover),
                                          imageUrl: '${snapshot.data[i].productoFoto}',
                                          imageBuilder: (context, imageProvider) => Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      left: 0,
                                      right: 0,
                                      /*  left: responsive.wp(1),
                                          top: responsive.hp(.5), */
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: responsive.wp(3),
                                              vertical: responsive.hp(.5),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(10),
                                                ),
                                                color: Colors.red),
                                            child: Text(
                                              'Nuevo',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: responsive.ip(1.5),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
                                            child: Center(
                                              child: Icon(
                                                Ionicons.md_heart,
                                                color: Colors.red,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: responsive.wp(2),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    right: responsive.wp(1.5),
                                    left: responsive.wp(1.5),
                                  ),
                                  height: responsive.hp(3),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'S/.${snapshot.data[i].productoPrecio}',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontFamily: 'Aeonik',
                                          fontSize: 17,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: responsive.wp(2),
                                          vertical: responsive.hp(.5),
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            /* borderRadius: BorderRadius.only(
                                                bottomRight: Radius.circular(10),
                                              ), */
                                            color: Colors.blue),
                                        child: Text(
                                          'Destacado',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: responsive.ip(1.3),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: responsive.wp(1.5),
                                    left: responsive.wp(1.5),
                                  ),
                                  child: Text(
                                    '${snapshot.data[i].productoNombre.toLowerCase()}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Aeonik',
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Container(
                        child: Center(child: Text('No aye')),
                      );
                    }
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
