/* import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

//933080841
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

    buttonBloc.changePage(3);

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
                      /* padding: EdgeInsets.only(
                        bottom: kBottomNavigationBarHeight * 1.5,
                      ), */
                      child: IndexedStack(
                        index: snapshot.data,
                        children: pageList,
                      ),
                    );
                  },
                ),
                /* Positioned(
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
                              selectedColor: Colors.green,
                            ),
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
               */],
            );
          }),
      bottomNavigationBar: StreamBuilder(
        stream: buttonBloc.selectPageStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            selectedItemColor: Colors.green[400],
            unselectedItemColor: Colors.red,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: responsive.ip(3),
                ),
                label: 'Principal',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesome5Solid.heart,
                  size: responsive.ip(2.7),
                ),
                label: 'Favoritos',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.near_me,
                    size: responsive.ip(3),
                  ),
                  label: 'Categorías'),
              BottomNavigationBarItem(
                icon: Stack(
                  children: <Widget>[
                    Icon(
                      MaterialIcons.shopping_cart,
                      size: responsive.ip(3),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        child: Text(
                          '4',
                          style: TextStyle(color: Colors.white, fontSize: responsive.ip(1)),
                        ),
                        alignment: Alignment.center,
                        width: responsive.ip(1.6),
                        height: responsive.ip(1.6),
                        decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                      ),
                      //child: Icon(Icons.brightness_1, size: 8,color: Colors.redAccent,  )
                    )
                  ],
                ),
                label: 'Carrito',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: responsive.ip(3),
                ),
                label: 'Cuenta',
              )
            ],
            currentIndex: buttonBloc.page,
            onTap: (index) => {
              buttonBloc.changePage(index),
            },
          );
        },
      ),
    );
  }
}
 */