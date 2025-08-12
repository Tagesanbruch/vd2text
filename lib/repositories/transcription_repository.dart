import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../models/transcription.dart';
import '../models/app_state.dart';
import '../services/api_service.dart';
import '../utils/isar_service.dart';

class TranscriptionRepository {
  final ApiService _apiService;

  TranscriptionRepository(this._apiService);

  Future<void> syncWithServer() async {
    try {
      final isar = await IsarService.isar;
      final prefs = await SharedPreferences.getInstance();
      
      // 获取上次同步时间
      final lastSyncTimestamp = prefs.getString('last_sync_timestamp');
      DateTime? since;
      if (lastSyncTimestamp != null) {
        since = DateTime.parse(lastSyncTimestamp);
      }

      // 从服务器获取更新
      final updates = await _apiService.fetchUpdates(since: since);

      // 更新本地数据库
      await isar.writeTxn(() async {
        for (final transcription in updates) {
          // 查找是否已存在相同的remoteId
          final existing = await isar.transcriptions
              .where()
              .remoteIdEqualTo(transcription.remoteId)
              .findFirst();

          if (existing != null) {
            // 更新现有记录
            transcription.id = existing.id;
          }
          
          await isar.transcriptions.put(transcription);
        }
      });

      // 更新同步时间戳
      await prefs.setString('last_sync_timestamp', DateTime.now().toIso8601String());
    } on DioException catch (e) {
      throw NetworkException(
        _getDioErrorMessage(e),
        code: e.response?.statusCode?.toString(),
        originalError: e,
      );
    } catch (e) {
      throw TranscriptionException('Failed to sync with server: $e');
    }
  }

  Future<List<Transcription>> getLocalTranscriptions() async {
    final isar = await IsarService.isar;
    return await isar.transcriptions
        .where()
        .sortByUpdatedAtDesc()
        .findAll();
  }

  Future<TaskInfo> createTranscription({
    required String url,
    bool summarize = false,
    String? asrEngine,
  }) async {
    try {
      return await _apiService.createTranscription(
        url: url,
        summarize: summarize,
        asrEngine: asrEngine,
      );
    } on DioException catch (e) {
      throw NetworkException(
        _getDioErrorMessage(e),
        code: e.response?.statusCode?.toString(),
        originalError: e,
      );
    } catch (e) {
      throw TranscriptionException('Failed to create transcription: $e');
    }
  }

  Future<Transcription?> getTranscriptionDetails(String id) async {
    try {
      final transcription = await _apiService.getTranscriptionDetails(id: id);
      
      // 同时更新本地数据库
      final isar = await IsarService.isar;
      await isar.writeTxn(() async {
        final existing = await isar.transcriptions
            .where()
            .remoteIdEqualTo(transcription.remoteId)
            .findFirst();

        if (existing != null) {
          transcription.id = existing.id;
        }
        
        await isar.transcriptions.put(transcription);
      });

      return transcription;
    } on DioException catch (e) {
      // 如果网络请求失败，尝试从本地获取
      final isar = await IsarService.isar;
      final local = await isar.transcriptions
          .where()
          .remoteIdEqualTo(id)
          .findFirst();
      
      if (local != null) {
        return local; // 返回本地缓存的数据
      }
      
      throw NetworkException(
        _getDioErrorMessage(e),
        code: e.response?.statusCode?.toString(),
        originalError: e,
      );
    } catch (e) {
      // 如果网络请求失败，尝试从本地获取
      final isar = await IsarService.isar;
      final local = await isar.transcriptions
          .where()
          .remoteIdEqualTo(id)
          .findFirst();
      
      if (local != null) {
        return local; // 返回本地缓存的数据
      }
      
      throw TranscriptionException('Failed to get transcription details: $e');
    }
  }

  String _getDioErrorMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return '连接超时，请检查网络连接';
      case DioExceptionType.sendTimeout:
        return '发送请求超时';
      case DioExceptionType.receiveTimeout:
        return '接收响应超时';
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        switch (statusCode) {
          case 400:
            return '请求参数错误';
          case 401:
            return '未授权访问';
          case 403:
            return '访问被禁止';
          case 404:
            return '请求的资源不存在';
          case 500:
            return '服务器内部错误';
          case 502:
            return '网关错误';
          case 503:
            return '服务不可用';
          default:
            return '请求失败 (状态码: $statusCode)';
        }
      case DioExceptionType.cancel:
        return '请求已取消';
      case DioExceptionType.connectionError:
        return '网络连接错误，请检查网络设置';
      case DioExceptionType.unknown:
        return '未知网络错误';
      default:
        return '网络请求失败';
    }
  }
}
