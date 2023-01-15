import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:newrelic_mobile/newrelic_mobile.dart';

import '../config/env.dart';

class BackgroundRemoveRepository {
  static Future<Uint8List> removeImageBackgroundApi(String imagePath) async {
    var id = await NewrelicMobile.instance
        .startInteraction("Remove image Background");
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Env.i['API_URL_REMOVE_BG'] ?? ''),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        'image_file',
        imagePath,
      ),
    );
    request.headers.addAll({'X-API-Key': Env.i['API_KEY_REMOVE_BG'] ?? ''});
    final response = await request.send();
    if (response.statusCode == 200) {
      http.Response transparentImageResponse =
          await http.Response.fromStream(response);
      NewrelicMobile.instance.endInteraction(id);
      return transparentImageResponse.bodyBytes;
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }
}
