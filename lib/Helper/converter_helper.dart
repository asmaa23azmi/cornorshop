import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

mixin ConverterHelper {
  Future<File> convertImgLinkToFile(String link) async {
    var url = Uri.parse(link);
    var response = await http.get(url);

    var directory = await getApplicationDocumentsDirectory();
    var name = '${DateTime.now().toString()}.png';
    var path = join(directory.path, name);

    File file = File(path);
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }
}
