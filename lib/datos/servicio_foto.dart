import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ServicioFoto {
  final _picker = ImagePicker();

  /// Toma o elige una foto y deja que el usuario recorte la tabla.
  /// Devuelve la ruta del archivo recortado, o null si cancela.
  Future<String?> obtenerTabla(ImageSource origen) async {
    final foto = await _picker.pickImage(source: origen, imageQuality: 95);
    if (foto == null) return null;

    final recorte = await ImageCropper().cropImage(
      sourcePath: foto.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Encuadra solo la tabla',
          toolbarColor: Colors.indigo,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false,
        ),
        IOSUiSettings(title: 'Encuadra solo la tabla'),
      ],
    );
    return recorte?.path;
  }
}
