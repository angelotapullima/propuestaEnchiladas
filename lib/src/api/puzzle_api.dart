import 'package:http/http.dart' as http;
import 'package:propuesta_enchiladas/src/database/puzzle_database.dart';
import 'package:propuesta_enchiladas/src/models/puzzle_model.dart';

import 'dart:async';
import 'dart:convert';

import 'package:propuesta_enchiladas/src/utils/preferencias_usuario.dart';

class PuzzleApi {
  final String _url = 'https://delivery.lacasadelasenchiladas.pe';
  final prefs = Preferences();
  //final rankingDatabase = RankingDatabase();
  final puzzleDatabase = PuzzleDatabase();
  Future<List<PuzzleDatum>> obtenerImagenesPuzzle() async {
    final url = '$_url/api/puzzle/listar_imagenes_activa';
    final List<PuzzleDatum> list = [];
    final resp = await http.post((Uri.parse(url)), body: {'app': 'true', 'tn': prefs.token});

    final decodedData = json.decode(resp.body);
    if (decodedData['result']['code'] == 1) {
      if (decodedData['result']['data'].length > 0) {
        for (int i = 0; i < decodedData['result']['data'].length; i++) {
          PuzzleDatum puzzle = PuzzleDatum();
          puzzle.idImagen = decodedData['result']['data'][i]['id_imagen'];
          puzzle.imagenRuta = decodedData['result']['data'][i]['imagen_ruta'];
          puzzle.imagenTitulo = decodedData['result']['data'][i]['imagen_titulo'];
          puzzle.imagenSubida = decodedData['result']['data'][i]['imagen_subida'];
          puzzle.imagenInicio = decodedData['result']['data'][i]['imagen_inicio'];
          puzzle.imagenFin = decodedData['result']['data'][i]['imagen_fin'];
          puzzle.imagenEstado = decodedData['result']['data'][i]['imagen_estado'];

          await puzzleDatabase.insertarPuzzle(puzzle);
          list.add(puzzle);
        }
      }
      return list;
    } else {
      return [];
    }
  }
}
/* 
  Future<bool> obtenerTiemposDia(String fecha) async {
    try {
      final formatFecha = fecha.split(' ');
      var formatFecha1 = formatFecha[0].toString();
      print('token ${prefs.token}');
      final url = '$_url/api/puzzle/listar_tiempos_dia_nuevo';
      final resp = await http.post(
        (Uri.parse(url)),
        body: {'app': 'true', 'tn': prefs.token, 'puzzle_fecha': formatFecha1.toString()},
      );

      final decodedData = json.decode(resp.body);

      if (decodedData['result']['code'] == 1) {
        if (decodedData['result']['data'].length > 0) {
          for (int i = 0; i < decodedData['result']['data'].length; i++) {
            RankingPuzzle puzzle = RankingPuzzle();
            puzzle.idPuzzle = decodedData['result']['data'][i]['id_user'];
            puzzle.personName = decodedData['result']['data'][i]['person_name'];
            puzzle.puzzleFecha = decodedData['result']['data'][i]['puzzle_fecha'];
            puzzle.userImage = decodedData['result']['data'][i]['user_image'];
            puzzle.puzzleTiempo = decodedData['result']['data'][i]['puzzle_tiempo'];
            await rankingDatabase.insertarRanking(puzzle);
          }
        }
        return true;
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      showToast("Problemas con la conexión a internet", 2, ToastGravity.TOP);
      return false;
    }
  }

  Future<bool> subirTiempo(String tiempo, String idImagen) async {
    try {
      final url = '$_url/api/puzzle/subir_tiempo';

      final resp = await http.post(
        (Uri.parse(url)),
        body: {'app': 'true', 'puzzle_tiempo': tiempo, 'id_user': prefs.idUser, 'id_imagen': idImagen, 'tn': prefs.token},
      );

      final decodedData = json.decode(resp.body);
      if (decodedData['result']['code'] == 1) {
        if (decodedData['result']['data'].length > 0) {
          for (int i = 0; i < decodedData['result']['data'].length; i++) {
            RankingPuzzle puzzle = RankingPuzzle();
            puzzle.idPuzzle = decodedData['result']['data'][i]['id_user'];
            puzzle.personName = decodedData['result']['data'][i]['person_name'];
            puzzle.puzzleFecha = decodedData['result']['data'][i]['puzzle_fecha'];
            puzzle.userImage = decodedData['result']['data'][i]['user_image'];
            puzzle.puzzleTiempo = decodedData['result']['data'][i]['puzzle_tiempo'];
            await rankingDatabase.insertarRanking(puzzle);
          }
        }
        return true;
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      showToast("Problemas con la conexión a internet", 2, ToastGravity.TOP);
      return false;
    }
  }
}
 */