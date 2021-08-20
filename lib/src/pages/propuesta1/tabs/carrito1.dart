import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:propuesta_enchiladas/src/bloc/provider.dart';
import 'package:propuesta_enchiladas/src/models/productos_model.dart';
import 'package:propuesta_enchiladas/src/utils/responsive.dart';
import 'package:google_fonts/google_fonts.dart';

class Carrito1 extends StatelessWidget {
  const Carrito1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productoBloc = ProviderBloc.prod(context);
    productoBloc.obtenerProductosdeliveryEnchiladasPorCategoria('3');
    final responsive = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Carrito',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
            fontSize: 19,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: productoBloc.productosEnchiladasStream,
        builder: (BuildContext context, AsyncSnapshot<List<ProductosData>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return ListView.builder(
                  itemCount: (snapshot.data.length > 4) ? 5 : snapshot.data.length,
                  itemBuilder: (context, i) {
                    if (i == 4) {
                      return Container(
                        color: Color(0xE1F0EFEF),
                        child: Column(
                          children: [
                            Container(
                              height: responsive.hp(4),
                              width: double.infinity,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: responsive.hp(3),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: responsive.wp(2),
                                vertical: responsive.hp(1),
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: responsive.wp(3),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: responsive.wp(3),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'SubTotal',
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          'S/.23.00',
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: responsive.hp(1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: responsive.wp(3),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Envío',
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          'S/.0.0',
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: responsive.hp(1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: responsive.wp(3),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Total',
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          'S/.23.00',
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: responsive.hp(2),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: responsive.wp(3),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: responsive.wp(3),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.orange[300],
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              height: responsive.hp(8),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Icon(
                                    Ionicons.ios_cart,
                                    color: Color(0xFF677281),
                                  ),
                                  SizedBox(
                                    width: responsive.wp(3),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '4 Productos agregados',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[700],
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        'S/23.00',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    'Pagar',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              ),
                            ),
                            SizedBox(
                              height: responsive.hp(8),
                            ),
                          ],
                        ),
                      );
                    }
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsive.wp(2),
                        vertical: responsive.hp(.5),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: responsive.wp(20),
                                height: responsive.hp(10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) => Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Center(
                                        child: CupertinoActivityIndicator(),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Center(
                                        child: Icon(Icons.error),
                                      ),
                                    ),
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
                              SizedBox(
                                width: responsive.wp(3),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${snapshot.data[i].productoNombre.toLowerCase()}',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      'S/.${snapshot.data[i].productoPrecio}',
                                      style: GoogleFonts.poppins(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: responsive.wp(3),
                              ),
                              Container(
                                width: responsive.wp(15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          '-',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Aeonik',
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '1',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Aeonik',
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '+',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Aeonik',
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: responsive.wp(3),
                              ),
                              Icon(Icons.delete, color: Colors.grey),
                              SizedBox(
                                width: responsive.wp(3),
                              ),
                            ],
                          ),
                          Divider()
                        ],
                      ),
                    );
                  });
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
    );
  }
}
