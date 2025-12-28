import 'dart:io';
import 'package:interior_design/features/upload/data/services/ai_api_service.dart';

class AIRepository {
  final AIAPIService _apiService = AIAPIService();

  Future<Map<String, dynamic>> classify(File image) async {
    final raw = await _apiService.classifyRoom(image);
    // FastAPI returns JSON like {"class":"bedroom","confidence":0.9234}
    return raw;
  }
}
