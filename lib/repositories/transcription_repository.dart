import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transcription.dart';
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
    } catch (e) {
      throw Exception('Failed to sync with server: $e');
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
  }) async {
    return await _apiService.createTranscription(
      url: url,
      summarize: summarize,
    );
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
    } catch (e) {
      // 如果网络请求失败，尝试从本地获取
      final isar = await IsarService.isar;
      return await isar.transcriptions
          .where()
          .remoteIdEqualTo(id)
          .findFirst();
    }
  }
}
