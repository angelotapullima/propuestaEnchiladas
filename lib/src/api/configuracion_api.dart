import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:propuesta_enchiladas/src/database/pantalla_database.dart';
import 'package:propuesta_enchiladas/src/database/producto_database.dart';
import 'package:propuesta_enchiladas/src/database/puzzle_database.dart';
import 'package:propuesta_enchiladas/src/models/pantalla_model.dart';
import 'package:propuesta_enchiladas/src/models/productos_model.dart';
import 'package:propuesta_enchiladas/src/models/puzzle_model.dart';
import 'package:propuesta_enchiladas/src/utils/preferencias_usuario.dart';

class ConfiguracionApi {
  final String _url = 'https://delivery.lacasadelasenchiladas.pe';

  final prefs = new Preferences();
  final pantallaDatabase = PantallaDatabase();
  final productoDatabase = ProductoDatabase();

  Future<bool> configuracion() async {
    try {
      final url = '$_url/api/categoria/configuracion';
      final resp = await http.post((Uri.parse(url)), body: {'numero': '1'});
      final Map<String, dynamic> decodedData = json.decode(resp.body);
      if (decodedData['result']['code'] == 1) {
        for (int z = 0; z < decodedData['result']['data']['bolsa'].length; z++) {
          ProductosData productosData = ProductosData();
          productosData.idProducto = decodedData['result']['data']['bolsa'][z]['id_producto'];
          productosData.idCategoria = decodedData['result']['data']['bolsa'][z]['id_categoria'];
          productosData.productoNombre = decodedData['result']['data']['bolsa'][z]['producto_nombre'];
          productosData.productoPrecio = decodedData['result']['data']['bolsa'][z]['producto_precio'];
          productosData.productoUnidad = decodedData['result']['data']['bolsa'][z]['producto_unidad'];
          productosData.productoEstado = decodedData['result']['data']['bolsa'][z]['producto_estado'];
          productosData.productoFavorito = 0;
          productosData.productoComentario = '';

          productoDatabase.insertarProductosDb(productosData);

          prefs.idBolsa = decodedData['result']['data']['bolsa'][z]['id_producto'];
        }

        for (int a = 0; a < decodedData['result']['data']['tupper'].length; a++) {
          ProductosData productosData = ProductosData();
          productosData.idProducto = decodedData['result']['data']['tupper'][a]['id_producto'];
          productosData.idCategoria = decodedData['result']['data']['tupper'][a]['id_categoria'];
          productosData.productoNombre = decodedData['result']['data']['tupper'][a]['producto_nombre'];
          productosData.productoPrecio = decodedData['result']['data']['tupper'][a]['producto_precio'];
          productosData.productoUnidad = decodedData['result']['data']['tupper'][a]['producto_unidad'];
          productosData.productoEstado = decodedData['result']['data']['tupper'][a]['producto_estado'];
          productosData.productoFavorito = 0;
          productosData.productoComentario = '';

          productoDatabase.insertarProductosDb(productosData);

          prefs.idTupper = decodedData['result']['data']['tupper'][a]['id_producto'];
        }

        var tamanoPublicidad = decodedData['result']['data']['publicidad'].length;

        if (tamanoPublicidad > 0) {
          // await publicidadDatabase.deletePublcidadDb();

          /*  for (int j = 0; j < decodedData['result']['data']['publicidad'].length; j++) {
            PublicidadModel publicidadModel = PublicidadModel();

            publicidadModel.idPublicidad = j.toString();
            publicidadModel.publicidadEstado = decodedData['result']['data']['publicidad'][j]['publicidad_estado'];
            publicidadModel.publicidadImagen = decodedData['result']['data']['publicidad'][j]['publicidad_imagen'];
            publicidadModel.publicidadTipo = decodedData['result']['data']['publicidad'][j]['publicidad_tipo'];
            publicidadModel.idRelacionado = decodedData['result']['data']['publicidad'][j]['publicidad_id'];

            publicidadDatabase.insertarPublicidad(publicidadModel);
          } */
        }

        /*  for (int i = 0; i < decodedData['result']['data']['zonas'].length; i++) {
          Zona zona = Zona();

          zona.idZona = decodedData['result']['data']['zonas'][i]['id_zona'];
          zona.zonaNombre = decodedData['result']['data']['zonas'][i]['zona_nombre'];
          zona.zonaPedidoMinimo = decodedData['result']['data']['zonas'][i]['zona_pedido_minimo'];
          zona.zonaImagen = decodedData['result']['data']['zonas'][i]['zona_imagen'];
          zona.zonaDescripcion = decodedData['result']['data']['zonas'][i]['zona_descripcion'];
          zona.zonaEstado = decodedData['result']['data']['zonas'][i]['zona_estado'];
          zona.zonaTiempo = decodedData['result']['data']['zonas'][i]['zona_tiempo'];

          zona.recargoProductoNombre = decodedData['result']['data']['zonas'][i]['recargo'][0]['recargo_producto_nombre'];
          zona.recargoProductoPrecio = decodedData['result']['data']['zonas'][i]['recargo'][0]['recargo_producto_precio'];
          zona.deliveryProductoNombre = decodedData['result']['data']['zonas'][i]['delivery_rapido'][0]['delivery_producto_nombre'];
          zona.deliveryProductoPrecio = decodedData['result']['data']['zonas'][i]['delivery_rapido'][0]['delivery_producto_precio'];

          await zonaDatabase.insertarZonaDb(zona);
        } */

        for (int x = 0; x < decodedData['result']['data']['pantallas'].length; x++) {
          PantallaModel pantalla = PantallaModel();

          pantalla.idPantalla = decodedData['result']['data']['pantallas'][x]['id_pantalla'];
          pantalla.pantallaNombre = decodedData['result']['data']['pantallas'][x]['pantalla_nombre'];
          pantalla.pantallaOrden = decodedData['result']['data']['pantallas'][x]['pantalla_orden'];
          pantalla.pantallaFoto = decodedData['result']['data']['pantallas'][x]['pantalla_foto'];
          pantalla.pantallaEstado = decodedData['result']['data']['pantallas'][x]['pantalla_estado'];
          pantalla.pantallCategoria = decodedData['result']['data']['pantallas'][x]['pantalla_categorias'][0]['id_categoria'];

          await pantallaDatabase.insertarPantalla(pantalla);
        }

      

        /*  for (int t = 0;
            t < decodedData['result']['data']['adicionales'].length;
            t++) {
          ProductosData productosData = ProductosData();
          productosData.idProducto =decodedData['result']['data']['adicionales'][t]['id_producto'];
          productosData.idCategoria = '16';
          productosData.productoNombre = decodedData['result']['data']
              ['adicionales'][t]['producto_nombre'];
          productosData.productoFoto =
              decodedData['result']['data']['adicionales'][t]['producto_foto'];
          productosData.productoPrecio = decodedData['result']['data']
              ['adicionales'][t]['producto_precio'];
          productosData.productoCarta =
              decodedData['result']['data']['adicionales'][t]['producto_carta'];
          productosData.productoDelivery = decodedData['result']['data']
              ['adicionales'][t]['productoDelivery'];
          productosData.productoSeleccionado = '0';
          productosData.productoEstado = decodedData['result']['data']
              ['adicionales'][t]['producto_estado'];
          productosData.productoDescripcion = decodedData['result']['data']
              ['adicionales'][t]['producto_detalle'];

          await adicionalesDatabase.insertarProductosDb(productosData);
        } */

        return true;
      } else {
        return false;
      }
    } catch (error) {
      //print("Exception occured: $error stackTrace: $stacktrace");
      //showToast("Problemas con la conexión a internet", 2, ToastGravity.TOP);
      return false;
    }
  }
}
