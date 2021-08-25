import 'package:flutter/material.dart';
import 'package:propuesta_enchiladas/src/bloc/provider.dart';
import 'package:propuesta_enchiladas/src/pages/propuesta2/tabs/carrito2.dart';
import 'package:propuesta_enchiladas/src/pages/propuesta2/tabs/categoria2.dart';
import 'package:propuesta_enchiladas/src/pages/propuesta2/tabs/favoritos2.dart';
import 'package:propuesta_enchiladas/src/pages/propuesta2/tabs/principal2.dart';
import 'package:propuesta_enchiladas/src/pages/propuesta2/tabs/usuario2.dart';
import 'package:propuesta_enchiladas/src/utils/responsive.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Home2 extends StatefulWidget {
  const Home2({Key key}) : super(key: key);

  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  List<Widget> pageList = [];

  @override
  void initState() {
    pageList.add(Principal2());
    pageList.add(Favoritos2());
    pageList.add(Categoria2());
    pageList.add(Carrito2());
    pageList.add(Usuario2());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = new Responsive.of(context);

    final buttonBloc = ProviderBloc.bottom(context);

    buttonBloc.changePage(0);

    return Scaffold(
      body: StreamBuilder(
          stream: buttonBloc.selectPageStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Stack(
              children: [
                StreamBuilder(
                  stream: buttonBloc.selectPageStream,
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    return Container(
                      padding: EdgeInsets.only(
                        bottom: kBottomNavigationBarHeight * 1.5,
                      ),
                      child: IndexedStack(
                        index: snapshot.data,
                        children: pageList,
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: kBottomNavigationBarHeight * 1.5,
                    padding: EdgeInsets.only(
                      bottom: responsive.hp(3),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(20),
                        topEnd: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: StreamBuilder(
                      stream: buttonBloc.selectPageStream,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: responsive.wp(2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  buttonBloc.changePage(0);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.home,
                                      size: responsive.ip(3),
                                      color: (buttonBloc.page == 0) ? Colors.red : Colors.grey,
                                    ),
                                    Text(
                                      'Inicio',
                                      style: TextStyle(
                                        fontSize: responsive.ip(1.6),
                                        color: (buttonBloc.page == 0) ? Colors.red : Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  buttonBloc.changePage(1);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FontAwesome5Solid.heart,
                                      size: responsive.ip(3),
                                      color: (buttonBloc.page == 1) ? Colors.red : Colors.grey,
                                    ),
                                    Text(
                                      'Favoritos',
                                      style: TextStyle(
                                        fontSize: responsive.ip(1.6),
                                        color: (buttonBloc.page == 1) ? Colors.red : Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                             InkWell(
                                onTap: () {
                                  buttonBloc.changePage(2);
                                },  
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.red.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 8,
                                        offset: Offset(0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    radius: responsive.ip(3),
                                    backgroundColor: Colors.red,
                                    child: Center(
                                      child: Icon(
                                        MaterialIcons.grid_on,
                                        color: Colors.white,
                                        size: responsive.ip(2.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  buttonBloc.changePage(3);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      MaterialIcons.shopping_cart,
                                      size: responsive.ip(3),
                                      color: (buttonBloc.page == 3) ? Colors.red : Colors.grey,
                                    ),
                                    Text(
                                      'Carrito',
                                      style: TextStyle(
                                        fontSize: responsive.ip(1.6),
                                        color: (buttonBloc.page == 3) ? Colors.red : Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  buttonBloc.changePage(4);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: responsive.ip(3),
                                      color: (buttonBloc.page == 4) ? Colors.red : Colors.grey,
                                    ),
                                    Text(
                                      'Usuario',
                                      style: TextStyle(
                                        fontSize: responsive.ip(1.6),
                                        color: (buttonBloc.page == 4) ? Colors.red : Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
