import 'package:flutter/material.dart';
import 'package:propuesta_enchiladas/src/bloc/provider.dart';
import 'package:propuesta_enchiladas/src/pages/propuesta1/tabs/carrito1.dart';
import 'package:propuesta_enchiladas/src/pages/propuesta1/tabs/categoria1.dart';
import 'package:propuesta_enchiladas/src/pages/propuesta1/tabs/favoritos1.dart';
import 'package:propuesta_enchiladas/src/pages/propuesta1/tabs/principal1.dart';
import 'package:propuesta_enchiladas/src/pages/propuesta1/tabs/usuario1.dart';
import 'package:propuesta_enchiladas/src/utils/responsive.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Home1 extends StatefulWidget {
  const Home1({Key key}) : super(key: key);

  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  List<Widget> pageList = [];

  @override
  void initState() {
    pageList.add(Principal1());
    pageList.add(Favoritos1());
    pageList.add(Categoria1());
    pageList.add(Carrito1());
    pageList.add(Usuario1());
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
                        return SalomonBottomBar(
                          currentIndex: snapshot.data,
                          onTap: (i) {
                            buttonBloc.changePage(i);
                          },
                          items: [
                            /// Home
                            SalomonBottomBarItem(
                              /*  Icon(AntDesign.stepforward),
                                Icon(Ionicons.ios_search),
                                Icon(FontAwesome.glass),
                                Icon(MaterialIcons.ac_unit),
                                Icon(FontAwesome5.address_book),
                                Icon(FontAwesome5Solid.address_book),
                                Icon(FontAwesome5Brands.$500px) */
                              icon: Icon(Ionicons.ios_home),
                              title: Text("Inicio"),
                              selectedColor: Colors.blue,
                            ),

                            /// Likes

                            /// Search
                            SalomonBottomBarItem(
                              icon: Icon(FontAwesome5Solid.heart),
                              title: Text("Favoritos"),
                              selectedColor: Colors.red,
                            ),

                            /// Profile
                            SalomonBottomBarItem(
                              icon: Icon(FontAwesome5Solid.box),
                              title: Text("Categorías"),
                              selectedColor: Colors.orange,
                            ),
                            SalomonBottomBarItem(
                              icon: Icon(MaterialIcons.shopping_cart),
                              title: Text("Carrito"),
                              selectedColor: Colors.orange,
                            ),
                            SalomonBottomBarItem(
                              icon: Icon(FontAwesome5Solid.user),
                              title: Text("Usuario"),
                              selectedColor: Colors.teal,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          }),
      /* bottomNavigationBar: StreamBuilder(
        stream: buttonBloc.selectPageStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return SalomonBottomBar(
            currentIndex: snapshot.data,
            onTap: (i) {
              buttonBloc.changePage(i);
            },
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: FaIcon(FontAwesomeIcons.home),
                title: Text("Inicio"),
                selectedColor: Colors.blue,
              ),

              /// Likes

              /// Search
              SalomonBottomBarItem(
                icon: FaIcon(FontAwesomeIcons.route),
                title: Text("Rutas"),
                selectedColor: Colors.teal,
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: FaIcon(FontAwesomeIcons.fire),
                title: Text("Eventos"),
                selectedColor: Colors.orange,
              ),
              SalomonBottomBarItem(
                icon: FaIcon(FontAwesomeIcons.userAlt),
                title: Text("Profile"),
                selectedColor: Colors.teal,
              ),
            ],
          );
        },
      ),
     */
    );
  }
}
