import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:propuesta_enchiladas/src/api/configuracion_api.dart';
import 'package:propuesta_enchiladas/src/bloc/provider.dart';
import 'package:propuesta_enchiladas/src/models/categoria_model.dart';
import 'package:propuesta_enchiladas/src/models/pantalla_model.dart';
import 'package:propuesta_enchiladas/src/pages/propuesta2/detalle_categoria.dart';
import 'package:propuesta_enchiladas/src/pages/propuesta2/tabs/categoria2.dart';
import 'package:propuesta_enchiladas/src/utils/circle.dart';
import 'package:propuesta_enchiladas/src/utils/responsive.dart';
import 'package:propuesta_enchiladas/src/utils/sliver_header_delegate.dart';

class Principal2 extends StatefulWidget {
  const Principal2({Key key}) : super(key: key);

  @override
  _Principal2State createState() => _Principal2State();
}

class _Principal2State extends State<Principal2> {
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
      backgroundColor: Color(0xE1F0EFEF),
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
                                  StreamBuilder(
                                    stream: categoriasBloc.categoriasPromociionesStream,
                                    builder: (context, AsyncSnapshot<List<CategoriaData>> cat) {
                                      if (cat.hasData) {
                                        if (cat.data.length > 0) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              /*  Padding(
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
                                               */
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
                                                    viewportFraction: 0.85),
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
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: List.generate(
                                                          cat.data.length,
                                                          (index) => Container(
                                                            width: (_currentPageNotifier.value >= index - 0.5 &&
                                                                    _currentPageNotifier.value < index + 0.5)
                                                                ? 10
                                                                : 5,
                                                            height: 5,
                                                            margin: EdgeInsets.symmetric(horizontal: 5),
                                                            decoration: BoxDecoration(
                                                              borderRadius: (_currentPageNotifier.value >= index - 0.5 &&
                                                                      _currentPageNotifier.value < index + 0.5)
                                                                  ? BorderRadius.circular(8)
                                                                  : BorderRadius.circular(10),
                                                              color: (_currentPageNotifier.value >= index - 0.5 &&
                                                                      _currentPageNotifier.value < index + 0.5)
                                                                  ? Colors.green
                                                                  : Colors.grey,
                                                              /*    shape: (_currentPageNotifier.value >= index - 0.5 &&
                                                                        _currentPageNotifier.value < index + 0.5)
                                                                    ? BoxShape.rectangle
                                                                    : BoxShape.circle*/
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
                                  /* Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      'Categorías',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Aeonik',
                                        fontSize: 20,
                                      ),
                                    ),
                                  ), */
                                  SizedBox(
                                    height: responsive.hp(2),
                                  ),
                                  StreamBuilder(
                                      stream: categoriasBloc.categoriasEnchiladasStream,
                                      builder: (context, AsyncSnapshot<List<CategoriaData>> snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data.length > 0) {
                                            return Container(
                                              height: responsive.hp(11),
                                              child: ListView.builder(
                                                itemCount: snapshot.data.length + 1,
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  if (index == 0) {
                                                    return InkWell(
                                                      onTap: () {
                                                        Navigator.of(context).push(PageRouteBuilder(
                                                          pageBuilder: (context, animation, secondaryAnimation) {
                                                            return Categoria2();
                                                          },
                                                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                            var begin = Offset(0.0, 1.0);
                                                            var end = Offset.zero;
                                                            var curve = Curves.ease;

                                                            var tween = Tween(begin: begin, end: end).chain(
                                                              CurveTween(curve: curve),
                                                            );

                                                            return SlideTransition(
                                                              position: animation.drive(tween),
                                                              child: child,
                                                            );
                                                          },
                                                        ));
                                                      },
                                                      child: Container(
                                                        width: responsive.hp(9),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets.symmetric(
                                                                horizontal: responsive.wp(4),
                                                              ),
                                                              height: responsive.hp(5.5),
                                                              width: responsive.hp(5.8),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(100),
                                                                color: Colors.red,
                                                              ),
                                                              child: Center(
                                                                child: Icon(
                                                                  Ionicons.ios_alert,
                                                                  color: Colors.white,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: responsive.hp(.5),
                                                            ),
                                                            Text(
                                                              'Categorías',
                                                              style: TextStyle(
                                                                fontSize: responsive.ip(1.2),
                                                                fontWeight: FontWeight.w600,
                                                                color: Colors.grey,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  index = index - 1;

                                                  return InkWell(
                                                    onTap: () {
                                                      Navigator.of(context).push(PageRouteBuilder(
                                                        pageBuilder: (context, animation, secondaryAnimation) {
                                                          return Detallecategoria(
                                                            idCategoria: '${snapshot.data[index].idCategoria}',
                                                            categoriaNombre: '${snapshot.data[index].categoriaNombre}',
                                                          );
                                                        },
                                                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                          var begin = Offset(0.0, 1.0);
                                                          var end = Offset.zero;
                                                          var curve = Curves.ease;

                                                          var tween = Tween(begin: begin, end: end).chain(
                                                            CurveTween(curve: curve),
                                                          );

                                                          return SlideTransition(
                                                            position: animation.drive(tween),
                                                            child: child,
                                                          );
                                                        },
                                                      ));
                                                    },
                                                    child: Container(
                                                      width: responsive.hp(9),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            height: responsive.ip(5),
                                                            width: responsive.ip(5),
                                                            child: SvgPicture.network(
                                                              '${snapshot.data[index].categoriaIcono}',
                                                              semanticsLabel: 'A shark?!',
                                                              //color:Colors.black,
                                                              placeholderBuilder: (BuildContext context) => Container(
                                                                  padding: const EdgeInsets.all(30.0), child: const CircularProgressIndicator()),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: responsive.hp(.5),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.symmetric(
                                                              horizontal: responsive.wp(1),
                                                            ),
                                                            child: Text(
                                                              '${snapshot.data[index].categoriaNombre.toLowerCase()}',
                                                              maxLines: 2,
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                fontSize: responsive.ip(1.2),
                                                                fontWeight: FontWeight.w600,
                                                                color: Colors.grey,
                                                              ),
                                                            ),
                                                          )
                                                        ],
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
                                ],
                              );
                            }
                            if (index == snapshot.data.length) {
                              return SizedBox(
                                height: responsive.hp(1),
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
    double altoCard = 30.0;
    double anchoCard = 35.0;
    BoxFit boxfit;
    String tipo;
    if (pantallaModel.idPantalla == '2') {
      //market

      altoCard = 23.0;
      anchoCard = 25;

      boxfit = BoxFit.cover;

      tipo = 'categoria';
    } else if (pantallaModel.idPantalla == '1') {
      //carta Principal

      altoCard = 15.0;
      anchoCard = 18;

      tipo = 'categoria';

      boxfit = BoxFit.fill;
    } else if (pantallaModel.idPantalla == '4') {
      //carta Principal

      altoCard = 15.0;
      anchoCard = 18;

      tipo = 'categoria';

      boxfit = BoxFit.fill;
    } else if (pantallaModel.idPantalla == '5') {
      //carta Principal

      altoCard = 15.0;
      anchoCard = 18;

      tipo = 'categoria';

      boxfit = BoxFit.fill;
    } else if (pantallaModel.idPantalla == '3') {
      //puzzle
      altoCard = 26.0;
      anchoCard = 20;

      boxfit = BoxFit.fill;

      tipo = 'puzzle';
    } else {
      boxfit = BoxFit.fill;
      tipo = 'producto';
    }

    return ListView.builder(
        padding: EdgeInsets.only(
          top: responsive.hp(1),
        ),
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context, j) {
          if (j == 0) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '${pantallaModel.pantallaNombre}',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Aeonik',
                  fontSize: 19,
                ),
              ),
            );
          }
          return GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: .9,
              crossAxisCount: 2,
              mainAxisSpacing: responsive.hp(1),
            ),
            itemCount: (pantallaModel.items.length > 3) ? 4 : pantallaModel.items.length,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  width: responsive.ip(anchoCard),
                  //height: (tipo=='puzzle')?responsive.hp(20):responsive.ip(altoCard),
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
                            width: double.infinity,
                            height: (tipo == 'puzzle')
                                ? responsive.hp(25)
                                : (tipo == 'producto')
                                    ? responsive.ip(altoCard) - responsive.ip(15)
                                    : responsive.ip(altoCard) - responsive.ip(0),
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
                                  : Container()
                              : Container(),
                        ],
                      ),
                      (tipo == 'puzzle')
                          ? Container()
                          : Container(
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
                                        color: Colors.orange),
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
                      (tipo == 'puzzle')
                          ? Container()
                          : Padding(
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
                ),
              );
            },
          );
        });
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
        maxHeight: responsive.ip(14) + kToolbarHeight,
        minHeight: responsive.ip(14) + kToolbarHeight,
        child: Container(
          color: Color(0xE1F0EFEF),
          // color: Colors.red,
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 23,
                  ),
                  height: responsive.hp(9),
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
                        decoration: BoxDecoration(
                          color: Color(0x30F3B440),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: responsive.wp(2),
                          vertical: responsive.hp(.5),
                        ),
                        child: Icon(
                          Ionicons.ios_cart,
                          color: Color(0xFF585D64),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: responsive.hp(1),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: responsive.wp(6),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: responsive.hp(4),
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(
                        width: responsive.wp(3),
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: Text(
                          '¿Qué está buscando?',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
