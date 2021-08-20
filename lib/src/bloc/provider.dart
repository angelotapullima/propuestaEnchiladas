import 'package:flutter/material.dart';
import 'package:propuesta_enchiladas/src/bloc/bottom_navigation_bloc.dart';
import 'package:propuesta_enchiladas/src/bloc/categorias_bloc.dart';
import 'package:propuesta_enchiladas/src/bloc/favoritos_bloc.dart';
import 'package:propuesta_enchiladas/src/bloc/pantalla_bloc.dart';
import 'package:propuesta_enchiladas/src/bloc/procentaje_bloc.dart';
import 'package:propuesta_enchiladas/src/bloc/productos_id_bloc.dart';

class ProviderBloc extends InheritedWidget {
  final categoriasBloc = new CategoriasBloc();
  final bottomNaviBloc = BottomNaviBloc();
  final favoritosBloc = new FavoritosBloc();
  final productosId = new ProductosBloc();
  final porcentajesBloc = PorcentajesBloc();
  final pantallaBloc = PantallaBloc();

  static ProviderBloc _instancia;

  //generamos un Singleton de Provider para toda la aplicacion
  factory ProviderBloc({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new ProviderBloc._internal(key: key, child: child);
    }

    return _instancia;
  }

  ProviderBloc._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static CategoriasBloc cat(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).categoriasBloc;
  }

  static BottomNaviBloc bottom(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).bottomNaviBloc;
  }

  static FavoritosBloc fav(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).favoritosBloc;
  }

  static ProductosBloc prod(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).productosId;
  }

  static PorcentajesBloc porcentaje(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).porcentajesBloc;
  }

  static PantallaBloc pantalla(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).pantallaBloc;
  }
}
