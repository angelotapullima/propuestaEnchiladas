import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propuesta_enchiladas/src/bloc/provider.dart';
import 'package:propuesta_enchiladas/src/models/productos_model.dart';
import 'package:propuesta_enchiladas/src/utils/responsive.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controllerBusquedaProducto = TextEditingController();
  final _currentPageNotifier = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _controllerBusquedaProducto.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productosBloc = ProviderBloc.prod(context);
      productosBloc.obtenerProductoPorQueryDelivery('');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productosBloc = ProviderBloc.prod(context);
    //productosBloc.obtenerProductoPorQueryDelivery('$query');
    final responsive = Responsive.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BackButton(),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsive.wp(2),
                      ),
                      width: double.infinity,
                      height: responsive.hp(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.grey[100],
                              child: TextField(
                                controller: _controllerBusquedaProducto,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: '¿Qué esta buscando?',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.black45),
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: responsive.hp(0),
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value.length >= 0 && value != ' ') {
                                    _currentPageNotifier.value = true;
                                    productosBloc.obtenerProductoPorQueryDelivery('$value');
                                    //agregarHistorial(context, value, 'pro');
                                  }
                                },
                                onSubmitted: (value) {
                                  /*  setState(() {
                                          expandFlag = false;
                                        }); */
                                  if (value.length >= 0 && value != ' ') {
                                    productosBloc.obtenerProductoPorQueryDelivery('$value');
                                    //agregarHistorial(context, value, 'pro');
                                  }
                                },
                                onTap: () {
                                  /*  setState(() {
                                          expandFlag = true;
                                        }); */
                                },
                              ),
                            ),
                          ),
                          ValueListenableBuilder(
                              valueListenable: _currentPageNotifier,
                              builder: (BuildContext context, bool data, Widget child) {
                                return (data)
                                    ? InkWell(
                                        onTap: () {
                                          productosBloc.obtenerProductoPorQueryDelivery(' ggggggggg');
                                          _controllerBusquedaProducto.text = '';
                                          setState(() {});
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          radius: responsive.ip(1.5),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: responsive.ip(2),
                                          ),
                                        ),
                                      )
                                    : Container();
                              })
                          /*  Container(
                            height: responsive.ip(3),
                            width: responsive.ip(3),
                            color: Colors.red,
                            child: Center(
                              child: IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    _controllerBusquedaProducto.text = '';
                                    /*  setState(() {
                                    expandFlag = true;
                                  }); */
                                  }),
                            ),
                          ), */
                        ],
                      ),
                    ),
                  ),
                  /*  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        /*  if (_controllerBusquedaProducto.text.length >= 0 && _controllerBusquedaProducto.text != ' ') {
                                setState(() {
                                  expandFlag = false;
                                });
                                busquedaBloc.obtenerBusquedaNegocio(context, '${_controllerBusquedaProducto.text}');
                                agregarHistorial(context, _controllerBusquedaProducto.text, 'pro');
                              } else {
                                setState(() {
                                  expandFlag = true;
                                });
                              } */
                      }), */
                  SizedBox(
                    width: responsive.wp(3),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: productosBloc.productosQueryStream,
                builder: (BuildContext context, AsyncSnapshot<List<ProductosData>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length > 0) {
                      return GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: .85,
                            crossAxisCount: 3,
                            mainAxisSpacing: responsive.hp(2),
                            crossAxisSpacing: responsive.wp(0),
                          ),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: responsive.wp(2),
                                vertical: responsive.hp(.5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: responsive.hp(10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Stack(
                                        children: [
                                          CachedNetworkImage(
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
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: responsive.wp(2),
                                                vertical: responsive.hp(.5),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(10),
                                                  ),
                                                  /* borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(10),
                                                ), */
                                                  color: Colors.blue),
                                              child: Text(
                                                'Destacado',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'S/.${snapshot.data[i].productoPrecio}',
                                        style: GoogleFonts.poppins(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${snapshot.data[i].productoNombre.toLowerCase()}',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    } else {
                      return Center(
                          child: Text(
                        'No existen productos con ese nombre',
                        style: TextStyle(
                          fontSize: responsive.ip(1.9),
                        ),
                      ));
                    }
                  } else {
                    return Center(child: CupertinoActivityIndicator());
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
