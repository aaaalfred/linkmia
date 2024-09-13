// Path: lib/services/google_vision_service.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:googleapis/vision/v1.dart' as vision;
import 'package:googleapis_auth/auth_io.dart' as auth;

class GoogleVisionService {
  static final credentialsJson = {
    "type": "service_account",
    "project_id": "linkmiine",
    "private_key_id": "bf2a153c1af43d75d84c909c6b92ae2902836639",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCdwGg6J1dX9HPv\n8++ueeTGwCwfHfoihplhwfJ871gyO0ojxl8w5AfVHNz+87fmURRLT54CYZJnSbT2\nOYjDrx1UJCIKdLKWEJA59pQmsOdf59RcL73kFb3fdbv+jCXeCmG37oFq58IhGI1L\nspdG+T88OWnkvhp/eWm0HQUphnKwqyTO+PPaVwNbuh+A5PnHWW2EiC4lvGMKAV4G\naRBvmrlvX8JfRvYq0Yv1oXcztp3g7/M5xiTK9dchaHgnsBbufyZBfQyYxf3Y25oK\nJoBjLteGOV4npsdRHP5JTUslq/9iChDZI5TrPKo8Sywu4hv9Ku/V9oEUHP/E9RVD\nnhXP3bQ5AgMBAAECggEAERNgtNrJU5X8br7i9Onw36qxm/SsvMwBElniG6/0xgsw\n7Uptx2cHigQDz/0lrOKd5cEKg4t4Q4Hw+q4jpbrw28jFfog/RIsqcXvFcaK4iOMZ\nU5k/Xs8TrHqcDOOyvaQ2C6jfjWjk1JxJvyXnxiD4vVYhpkcFq0LDNGHnyyToiULx\nj+qgoSuKLKrnSD24Dd0J/+nNBCFkyxXrOUH1PpIuAUwpNLPRYyw84noRHRwXAH3G\ngDDjyuFmgqAQtUooeMTL3FVsHp+bNSU6td1O/Wj1mWRPrkqfFxpasEG4aK+DLTRd\nH2iJ0ey+TRYRENwfoUs3x3RIo0HbLGizMyqXykmE4QKBgQDed9HpFohZqgUTMZsd\nXsw3xV0xWsZmAZnLGdC0kT9gYfD1jx+OhPtiBRTCRGImlk014JcL6CSgRg6NIYts\nxKw5dnkwEclm5c+yp4aTd4cb1qzyLARjW/DM0GXogSCwRk3kABRsRZP8DJ8ziiK5\nK8jrFTQFssm1Hrp5mQGFas0BTQKBgQC1h24Kjj+Q7l3KvBccuu86CvUcxKrAB15T\nFIlmmnZR7RfQB55YBcTXDvj7Z/X8k0laU8r+MKZK/gvHLU1hFxXOp+RzFHT7PmFK\nXjivsPrXPk+vXxQokZfPzJxM+ds10lnc4z94htIHHD5n+V1IyMN8iXjvBNpimfbH\naJSEq7+InQKBgHQ6pbDh1NsDuSMOB7yQiqGYu9fNVVp1+6PhGOk9+Z6hjQK+g/4x\n/CR6Ax58G8uNO0mqzT+rSXdzIqcZn350QobDHw2+PTtFVf5BCE6DZFNnFXRxCtne\nbzCSsKuIy0tNb+RvJjxrHaXR8ls7EGkuNwqbSVKw1jGKnGJrTiAmbHUBAoGAN0Dd\nscDSgF7NlaPitRABOP2U1gjWoFSd1VPu7pgdY5pzIRLwk4JOA9e+2WcvbI24ShIv\nO2e7diAVna6gWukX7isUUiLr6H14R5aeUnvgHhwNTSf3jtGiD9IL0TJMEvnP+HgD\nHcCLtTZXmHZCeqEBP6rocHhdsJ2Ei/W9HxTX29ECgYBjQ1EHDsGiA94vWAMc/Fp5\nqueU7a4ZKHXwo/30rL2GIElsgsMi7EmYvf6eAA4SnEdk3Xlvj/JoysCHQ29C0ksF\nCdaLpPewmnDrGASnkdP2/pG1S8uGZ330UrRtRclXRhNrOpEtwRqpCogIcm2IoHvr\nK762N+6PCwdxxOcZ7uu9Vg==\n-----END PRIVATE KEY-----\n",
    "client_email": "link-445@linkmiine.iam.gserviceaccount.com",
    "client_id": "117547970588769567038",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/link-445%40linkmiine.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  };

  static Future<Map<String, String>> extractDataFromImage(Uint8List imageData) async {
    try {
      final credentials = auth.ServiceAccountCredentials.fromJson(credentialsJson);
      final client = await auth.clientViaServiceAccount(credentials, [vision.VisionApi.cloudVisionScope]);
      final visionApi = vision.VisionApi(client);

      final image = vision.Image(content: base64Encode(imageData));
      final feature = vision.Feature(type: 'TEXT_DETECTION', maxResults: 1);
      final request = vision.AnnotateImageRequest(image: image, features: [feature]);
      final batchRequest = vision.BatchAnnotateImagesRequest(requests: [request]);

      final response = await visionApi.images.annotate(batchRequest);

      if (response.responses!.isEmpty || response.responses![0].textAnnotations == null) {
        return {"Error": "No se detectó texto en la imagen"};
      }

      final fullText = response.responses![0].textAnnotations![0].description!;

      print('Texto completo extraído:');
      print(fullText);

      final datos = {
        "Apellido Paterno": "",
        "Apellido Materno": "",
        "Nombre": "",
        "Calle": "",
        "Colonia": "",
        "Municipio": "",
        "Codigo Postal": "",
        "CURP": "",
        "Fecha de Nacimiento": "",
        "Sexo": ""
      };

      final lines = fullText.split('\n');
      for (var i = 0; i < lines.length; i++) {
        print('Procesando línea: ${lines[i]}');
        if (lines[i].trim() == 'NOMBRE') {
          // El nombre está en las siguientes tres líneas
          if (i + 3 < lines.length) {
            datos["Apellido Paterno"] = lines[i + 1].trim();
            datos["Apellido Materno"] = lines[i + 2].trim();
            datos["Nombre"] = lines[i + 3].trim();
          }
        } else if (lines[i].startsWith('DOMICILIO')) {
          // La calle está en la siguiente línea después de 'DOMICILIO'
          if (i + 1 < lines.length) {
            datos["Calle"] = lines[i + 1].trim();
          }
          // Buscamos la línea que contiene la colonia y el código postal
          if (i + 2 < lines.length && lines[i + 2].startsWith('COL')) {
            var coloniaCP = lines[i + 2].trim();
            var partes = coloniaCP.split(' ');
            datos["Colonia"] = partes.sublist(1, partes.length - 1).join(' ').replaceAll('COL ', '');
            datos["Codigo Postal"] = partes.last;
          }
          // Buscamos la línea que contiene el municipio
          if (i + 3 < lines.length && lines[i + 3].contains(',')) {
            var municipioEstado = lines[i + 3].split(',');
            datos["Municipio"] = municipioEstado[0].trim();
          }
        } else if (lines[i].startsWith('CURP')) {
          if (i + 1 < lines.length) {
            datos["CURP"] = lines[i + 1].trim();
          }
        } else if (lines[i].startsWith('FECHA DE NACIMIENTO')) {
          if (i + 1 < lines.length) {
            datos["Fecha de Nacimiento"] = lines[i + 1].trim();
          }
        } else if (lines[i].startsWith('SEXO')) {
          datos["Sexo"] = lines[i].split(' ').last.trim();
        }
      }

      print('Datos extraídos de la imagen:');
      datos.forEach((key, value) {
        print('$key: $value');
      });

      client.close();
      return datos;
    } catch (e) {
      print('Error en extractDataFromImage: $e');
      return {"Error": e.toString()};
    }
  }
}