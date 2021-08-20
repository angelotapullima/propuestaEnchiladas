import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                        return SalomonBottomBar(
                          currentIndex: snapshot.data,
                          unselectedItemColor: Colors.grey,
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
                              selectedColor: Colors.red,
                            ),

                            /// Likes

                            /// Search
                            SalomonBottomBarItem(
                              icon: Icon(FontAwesome5Solid.heart),
                              title: Text("Favoritos"),
                              selectedColor: Colors.red,
                            ),

                            /// Profile
                            /*   SalomonBottomBarItem(
                              icon: Icon(FontAwesome5Solid.box),
                              title: Text("Categorías"),
                              selectedColor: Colors.orange,
                            ), */
                            SalomonBottomBarItem(
                              icon: Stack(
                                children: [
                                  Icon(MaterialIcons.shopping_cart),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      height: responsive.ip(1.4),
                                      width: responsive.ip(1.4),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '4',
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              title: Text("Carrito"),
                              selectedColor: Colors.red,
                            ),
                            SalomonBottomBarItem(
                              icon: Icon(FontAwesome5Solid.user),
                              title: Text("Usuario"),
                              selectedColor: Colors.red,
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
