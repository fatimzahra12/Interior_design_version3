import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AIAPIService {
  // Use 10.0.2.2 if testing on Android emulator
  // Use your PC LAN IP if testing on real device
  final String baseUrl = "http://10.0.2.2:8000";

  Future<Map<String, dynamic>> classifyRoom(File image) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/predict"),
    );

    request.files.add(await http.MultipartFile.fromPath("file", image.path));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      // Parse the JSON string into a Map
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to classify room: ${response.body}');
    }
  }
}
