/* import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propuesta_enchiladas/src/bloc/provider.dart';
import 'package:propuesta_enchiladas/src/models/categoria_model.dart';
import 'package:propuesta_enchiladas/src/pages/propuesta1/detalle_categoria.dart';
import 'package:propuesta_enchiladas/src/pages/search.dart';
import 'package:propuesta_enchiladas/src/utils/responsive.dart';

class Categoria1 extends StatelessWidget {
  const Categoria1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriasBloc = ProviderBloc.cat(context);
    categoriasBloc.obtenerCategoriasEnchiladas();

    final responsive = Responsive.of(context);
    return Scaffold(
      backgroundColor: Color(0xE1F0EFEF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Categorías',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
            fontSize: 19,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return SearchPage();
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
                    ),
                  );

                  //SearchPage
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: responsive.wp(4),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.wp(4),
                  ),
                  height: responsive.hp(5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '¿Qué esta buscando?',
                        style: TextStyle(
                          color: Color(0xffB0BED1),
                          fontFamily: 'PulpDisplay-Medium',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.search,
                        size: 26,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: responsive.hp(2),
              )
            ],
          ),
        ),
      ),
      body: StreamBuilder(
        stream: categoriasBloc.categoriasEnchiladasStream,
        builder: (context, AsyncSnapshot<List<CategoriaData>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Detallecategoria(
                            idCategoria: '${snapshot.data[i].idCategoria}',
                            categoriaNombre: '${snapshot.data[i].categoriaNombre}',
                            categoriaIcono: '${snapshot.data[i].categoriaIcono}',
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
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: responsive.wp(2),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: responsive.ip(4),
                                width: responsive.ip(4),
                                child: SvgPicture.network(
                                  '${snapshot.data[i].categoriaIcono}',
                                  semanticsLabel: 'A shark?!',
                                  placeholderBuilder: (BuildContext context) => Container(padding: const EdgeInsets.all(30.0), child: const CircularProgressIndicator()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${snapshot.data[i].categoriaNombre}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Aeonik-Medium',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Icon(Ionicons.ios_arrow_forward, color: Colors.black, size: responsive.hp(3)),
                            ],
                          ),
                        ),
                        Divider()
                      ],
                    ),
                  );
                },
              );
              /* return GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1,
                          crossAxisCount: 4,
                          mainAxisSpacing: responsive.hp(1),
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () {
                             
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: responsive.wp(13),
                                  height: responsive.wp(13),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(.7),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Icon(Ionicons.md_thumbs_up, color: Colors.white, size: responsive.hp(3)),
                                  ),
                                ),
                                Text(
                                  '${snapshot.data[i].categoriaNombre}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Aeonik-Medium',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                     */
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
 */