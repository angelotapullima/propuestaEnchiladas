import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propuesta_enchiladas/src/api/configuracion_api.dart';
import 'package:propuesta_enchiladas/src/bloc/provider.dart';
import 'package:propuesta_enchiladas/src/models/categoria_model.dart';
import 'package:propuesta_enchiladas/src/models/pantalla_model.dart';
import 'package:propuesta_enchiladas/src/models/productos_model.dart';
import 'package:propuesta_enchiladas/src/utils/circle.dart';
import 'package:propuesta_enchiladas/src/utils/constant.dart';
import 'package:propuesta_enchiladas/src/utils/responsive.dart';
import 'package:propuesta_enchiladas/src/utils/sliver_header_delegate.dart';

class Principal1 extends StatefulWidget {
  const Principal1({Key key}) : super(key: key);

  @override
  _Principal1State createState() => _Principal1State();
}

class _Principal1State extends State<Principal1> {
  final _currentPageNotifier = ValueNotifier<int>(1);
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    final categoriasBloc = ProviderBloc.cat(context);
    categoriasBloc.obtenerCategoriasEnchiladas();
    categoriasBloc.obtenerCategoriasPromociones();

    final pantallasBloc = ProviderBloc.pantalla(context);
    pantallasBloc.obtenerPantallas();

    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: pantallasBloc.pantallasStream,
          builder: (BuildContext context, AsyncSnapshot<List<PantallaModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                return CustomScrollView(
                  slivers: [
                    CustomHeaderPrincipal1(),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            if (index == 0) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      'Categorías',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Aeonik',
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: responsive.hp(2),
                                  ),
                                  StreamBuilder(
                                      stream: categoriasBloc.categoriasEnchiladasStream,
                                      builder: (context, AsyncSnapshot<List<CategoriaData>> snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data.length > 0) {
                                            return Container(
                                              height: responsive.hp(4),
                                              child: ListView.builder(
                                                itemCount: snapshot.data.length,
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: (index == 0) ? Color(0x4078ce74) : Colors.white,
                                                    ),
                                                    margin: EdgeInsets.only(left: responsive.wp(1)),
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: responsive.wp(3),
                                                      vertical: responsive.hp(.5),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        '${snapshot.data[index].categoriaNombre.toLowerCase()}',
                                                        style: TextStyle(
                                                          color: (index == 0) ? Colors.green[500] : Color(0xffB0BED1),
                                                          fontFamily: 'PulpDisplay-Medium',
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        } else {
                                          return Container();
                                        }
                                      }),
                                  SizedBox(
                                    height: responsive.hp(2),
                                  ),
                                  StreamBuilder(
                                    stream: categoriasBloc.categoriasPromociionesStream,
                                    builder: (context, AsyncSnapshot<List<CategoriaData>> cat) {
                                      if (cat.hasData) {
                                        if (cat.data.length > 0) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 16),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Promociones',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Aeonik',
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    ValueListenableBuilder(
                                                        valueListenable: _currentPageNotifier,
                                                        builder: (BuildContext context, int data, Widget child) {
                                                          return Text(
                                                            '${data + 1}',
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontFamily: 'Aeonik',
                                                              fontSize: 20,
                                                            ),
                                                          );
                                                        }),
                                                    Text(
                                                      '/',
                                                      style: TextStyle(
                                                        color: Color(0xff78ce74),
                                                        fontFamily: 'Aeonik',
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${cat.data.length}',
                                                      style: TextStyle(
                                                        color: Color(0xff78ce74),
                                                        fontFamily: 'Aeonik',
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: responsive.hp(1),
                                              ),
                                              CarouselSlider.builder(
                                                itemCount: cat.data.length,
                                                itemBuilder: (context, x, y) {
                                                  return InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                      margin: EdgeInsets.symmetric(horizontal: responsive.wp(1), vertical: responsive.hp(1)),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                      ),
                                                      height: responsive.hp(20),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                        child: CachedNetworkImage(
                                                          placeholder: (context, url) => Container(
                                                              width: double.infinity,
                                                              height: double.infinity,
                                                              child: Center(
                                                                child: CupertinoActivityIndicator(),
                                                              )),
                                                          errorWidget: (context, url, error) => Container(
                                                            width: double.infinity,
                                                            height: double.infinity,
                                                            child: Center(
                                                              child: Icon(Icons.error),
                                                            ),
                                                          ),
                                                          imageUrl: '${cat.data[x].categoriaBanner}',
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
                                                  );
                                                },
                                                options: CarouselOptions(
                                                    height: responsive.hp(20),
                                                    onPageChanged: (index, page) {
                                                      _currentPageNotifier.value = index;
                                                    },
                                                    enlargeCenterPage: true,
                                                    autoPlay: true,
                                                    autoPlayCurve: Curves.fastOutSlowIn,
                                                    autoPlayInterval: Duration(seconds: 6),
                                                    autoPlayAnimationDuration: Duration(milliseconds: 2000),
                                                    viewportFraction: 0.8),
                                              ),
                                              SizedBox(
                                                height: responsive.hp(1),
                                              ),
                                              ValueListenableBuilder(
                                                  valueListenable: _currentPageNotifier,
                                                  builder: (BuildContext context, int data, Widget child) {
                                                    return Container(
                                                      margin: EdgeInsets.symmetric(
                                                        horizontal: responsive.wp(10),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: List.generate(
                                                          cat.data.length,
                                                          (index) => Container(
                                                            width: 15,
                                                            height: 5,
                                                            margin: EdgeInsets.symmetric(horizontal: 5),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10),
                                                              color: (_currentPageNotifier.value >= index - 0.5 &&
                                                                      _currentPageNotifier.value < index + 0.5)
                                                                  ? Colors.green
                                                                  : Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ],
                                          );
                                        } else {
                                          return Container();
                                        }
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: responsive.hp(2),
                                  ),
                                ],
                              );
                            }
                            if (index == snapshot.data.length) {
                              return SizedBox(
                                height: responsive.hp(3),
                              );
                            }
                            return _cart(context, responsive, snapshot.data[index]);
                          },
                          childCount: snapshot.data.length + 1,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                final configuracionApi = ConfiguracionApi();
                configuracionApi.configuracion();
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              }
            } else {
              final configuracionApi = ConfiguracionApi();
              configuracionApi.configuracion();
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }
          }),
    );
  }

  Widget _cart(BuildContext context, Responsive responsive, PantallaModel pantallaModel) {
    double altoList = 25.0;
    double altoCard = 18.0;
    double anchoCard = 25.0;
    BoxFit boxfit;
    String tipo;
    if (pantallaModel.idPantalla == '2') {
      //market
      altoList = 28.0;
      altoCard = 23.0;
      anchoCard = 25;

      boxfit = BoxFit.cover;

      tipo = 'categoria';
    } else if (pantallaModel.idPantalla == '1') {
      //carta Principal
      altoList = 20.0;
      altoCard = 15.0;
      anchoCard = 18;

      tipo = 'categoria';

      boxfit = BoxFit.fill;
    } else if (pantallaModel.idPantalla == '4') {
      //carta Principal
      altoList = 20.0;
      altoCard = 15.0;
      anchoCard = 18;

      tipo = 'categoria';

      boxfit = BoxFit.fill;
    } else if (pantallaModel.idPantalla == '5') {
      //carta Principal
      altoList = 20.0;
      altoCard = 15.0;
      anchoCard = 18;

      tipo = 'categoria';

      boxfit = BoxFit.fill;
    } else if (pantallaModel.idPantalla == '3') {
      //puzzle
      altoList = 31.0;
      altoCard = 26.0;
      anchoCard = 20;

      boxfit = BoxFit.fill;

      tipo = 'puzzle';
    } else {
      boxfit = BoxFit.fill;
      tipo = 'producto';
    }

    return Container(
      margin: EdgeInsets.only(bottom: responsive.hp(1)),
      width: double.infinity,
      height: responsive.ip(altoList),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsive.wp(3)),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '${pantallaModel.pantallaNombre}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Aeonik',
                      fontSize: 20,
                    ),
                  ), /*  Text(
                    '${pantallaModel.pantallaNombre}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: responsive.ip(2.5), color: Colors.red, fontWeight: FontWeight.bold),
                  ), */
                ),
                GestureDetector(
                  onTap: () {
                    /*  if (pantallaModel.idPantalla == '1') {
                      final bottomBloc = ProviderBloc.bottom(context);
                      bottomBloc.changePage(2);
                    } else if (pantallaModel.idPantalla == '5') {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 400),
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return CategoriasPorTipo(
                              nombreTipo: 'Var 247',
                              tipo: '4',
                            );
                            //return DetalleProductitos(productosData: productosData);
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    } else if (pantallaModel.idPantalla == '4') {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 400),
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return CategoriasPorTipo(
                              nombreTipo: 'Café 247',
                              tipo: '3',
                            );
                            //return DetalleProductitos(productosData: productosData);
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    } else if (pantallaModel.idPantalla == '3') {
                      Navigator.pushNamed(context, 'HomePuzzle');
                    } else {
                      Arguments arg = new Arguments("${pantallaModel.pantallaNombre}", '${pantallaModel.pantallCategoria}');

                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 100),
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return CategoriasEspecialesPage(
                              arg: arg,
                            );
                            //return DetalleProductitos(productosData: productosData);
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    } */
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive.hp(1.5),
                      vertical: responsive.hp(.5),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Ver más',
                          style: TextStyle(fontSize: responsive.ip(1.5), color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: responsive.ip(2),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: responsive.hp(1),
          ),
          Container(
            height: responsive.ip(altoCard),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: pantallaModel.items.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return (tipo != 'producto')
                    ? GestureDetector(
                        onTap: () {
                          /*   if (tipo == 'categoria') {
                      Arguments arg = new Arguments("${pantallaModel.items[i].nombreItem}", '${pantallaModel.items[i].idCategoria}');

                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 100),
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return CategoriasEspecialesPage(
                              arg: arg,
                            );
                            //return DetalleProductitos(productosData: productosData);
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    } else if (tipo == 'producto') {
                      ProductosData productosData = ProductosData();
                      productosData.idProducto = pantallaModel.items[i].idProducto;

                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 100),
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return SliderDetalleProductos(
                              numeroItem: pantallaModel.items[i].numeroItem,
                              idCategoria: pantallaModel.items[i].idCategoria,
                              cantidadItems: pantallaModel.items[i].cantidadItems,
                            );
                            //return DetalleProductitos(productosData: productosData);
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    } else if (tipo == 'puzzle') {
                      Navigator.pushNamed(context, 'HomePuzzle');
                    } */
                        },
                        child: Container(
                          width: responsive.ip(anchoCard),
                          height: responsive.ip(altoCard),
                          padding: EdgeInsets.only(
                            left: responsive.wp(3),
                          ),
                          margin: EdgeInsets.only(
                            right: responsive.wp(1.5),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: responsive.ip(anchoCard),
                                height: responsive.ip(altoCard),
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
                                    errorWidget: (context, url, error) => Image(image: AssetImage('assets/carga_fallida.jpg'), fit: BoxFit.cover),
                                    imageUrl: '${pantallaModel.items[i].fotoItem}',
                                    imageBuilder: (context, imageProvider) => Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: boxfit,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              (tipo == 'producto')
                                  ? ('${pantallaModel.items[i].productoNuevo}' != '1')
                                      ? Positioned(
                                          /*  left: responsive.wp(1),
                                  top: responsive.hp(.5), */
                                          child: Container(
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
                                                fontSize: responsive.ip(1.7),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container()
                                  : Container(),
                              (tipo == 'producto')
                                  ? ('${pantallaModel.items[i].productoDestacado}' == '0')
                                      ? Positioned(
                                          right: 0,
                                          top: 0,
                                          /*  left: responsive.wp(1),
                                  top: responsive.hp(.5), */
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: responsive.wp(3),
                                              vertical: responsive.hp(.5),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(10),
                                                ),
                                                color: Colors.yellow[900]),
                                            child: Text(
                                              'Producto destacado',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: responsive.ip(1.7),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container()
                                  : Container(),
                              (tipo != 'puzzle')
                                  ? Positioned(
                                      right: 0,
                                      left: 0,
                                      bottom: 0,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: responsive.hp(2),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(.5),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${pantallaModel.items[i].nombreItem.toLowerCase()}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'PulpDisplay-Medium',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        width: responsive.ip(anchoCard) - responsive.ip(8),
                        margin: EdgeInsets.only(
                          right: responsive.wp(1.5),
                          left: responsive.wp(1.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: responsive.ip(anchoCard) - responsive.ip(8),
                              height: responsive.ip(altoCard) - responsive.ip(7),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
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
                                      errorWidget: (context, url, error) => Image(image: AssetImage('assets/carga_fallida.jpg'), fit: BoxFit.cover),
                                      imageUrl: '${pantallaModel.items[i].fotoItem}',
                                      imageBuilder: (context, imageProvider) => Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: boxfit,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    /*  left: responsive.wp(1),
                                  top: responsive.hp(.5), */
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: responsive.wp(3),
                                        vertical: responsive.hp(.5),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          color: Colors.yellow[900]),
                                      child: Text(
                                        'Producto destacado',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: responsive.ip(1),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
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
                                    'S/ 23',
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
                                        color: Colors.red),
                                    child: Text(
                                      'Nuevo',
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
                                '${pantallaModel.items[i].nombreItem.toLowerCase()}',
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
            ),
          )
        ],
      ),
    );
  }
}

class CustomHeaderPrincipal1 extends StatefulWidget {
  const CustomHeaderPrincipal1({
    Key key,
  }) : super(key: key);

  @override
  _CustomHeaderPrincipal1State createState() => _CustomHeaderPrincipal1State();
}

class _CustomHeaderPrincipal1State extends State<CustomHeaderPrincipal1> {
  //String saldoActual, comisionActual;

  TextEditingController inputfieldDateController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    inputfieldDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    //canchasBloc.obtenerSaldo();
    return SliverPersistentHeader(
      floating: true,
      delegate: SliverCustomHeaderDelegate(
        maxHeight: responsive.ip(12) + kToolbarHeight,
        minHeight: responsive.ip(12) + kToolbarHeight,
        child: Container(
          color: Colors.white,
          height: responsive.hp(11),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                SizedBox(
                  height: responsive.hp(3),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 23,
                  ),
                  height: responsive.hp(6),
                  child: Row(
                    children: [
                      CircleContainer(
                        radius: responsive.ip(2.3),
                        color: Colors.red[800],
                        widget: IconButton(
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: responsive.ip(2.3),
                          ),
                          onPressed: () {
                            //Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
                          },
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: responsive.hp(3),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              size: 26,
                              color: Colors.black,
                            ),
                            Text(
                              '¿Qué esta buscando?',
                              style: TextStyle(
                                color: Color(0xffB0BED1),
                                fontFamily: 'PulpDisplay-Medium',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: responsive.wp(3),
                      ),
                      Text(
                        '|',
                        style: TextStyle(
                          color: Color(0xffB0BED1),
                          fontFamily: 'PulpDisplay',
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        width: responsive.wp(3),
                      ),
                      Icon(
                        Ionicons.ios_cart,
                        color: Color(0xffB0BED1),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: responsive.hp(1),
                ),
                Divider()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
