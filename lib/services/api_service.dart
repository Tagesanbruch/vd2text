import 'package:dio/dio.dart';
import '../models/transcription.dart';
import 'dio_service.dart';

class ApiService {
  final DioService _dioService;
  
  ApiService(this._dioService);

  Future<TaskInfo> createTranscription({
    required String url,
    bool summarize = false,
    String? asrEngine,
  }) async {
    try {
      final transcriptionCreate = TranscriptionCreate(
        url: url,
        summarize: summarize,
        asrEngine: asrEngine,
      );

      final response = await _dioService.dio.post(
        '/api/transcriptions',
        data: transcriptionCreate.toJson(),
      );

      return TaskInfo.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to create transcription: ${e.message}');
    }
  }

  Future<List<Transcription>> fetchUpdates({DateTime? since}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (since != null) {
        queryParams['since'] = since.toIso8601String();
      }

      final response = await _dioService.dio.get(
        '/api/transcriptions',
        queryParameters: queryParams,
      );

      final List<dynamic> data = response.data;
      return data.map((json) => Transcription.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch updates: ${e.message}');
    }
  }

  Future<Transcription> getTranscriptionDetails({required String id}) async {
    try {
      final response = await _dioService.dio.get('/api/transcriptions/$id');
      return Transcription.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to get transcription details: ${e.message}');
    }
  }
}
