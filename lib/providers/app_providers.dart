import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transcription.dart';
import '../services/dio_service.dart';
import '../services/api_service.dart';
import '../repositories/transcription_repository.dart';

// Settings Provider
class SettingsNotifier extends StateNotifier<AsyncValue<String>> {
  SettingsNotifier() : super(const AsyncValue.loading()) {
    _loadServerIp();
  }

  Future<void> _loadServerIp() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ip = prefs.getString('server_ip') ?? 'http://localhost:8000';
      state = AsyncValue.data(ip);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> setServerIp(String ip) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('server_ip', ip);
      state = AsyncValue.data(ip);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, AsyncValue<String>>((ref) {
  return SettingsNotifier();
});

// Dio Service Provider
final dioServiceProvider = Provider<DioService?>((ref) {
  final serverIpAsync = ref.watch(settingsProvider);
  return serverIpAsync.when(
    data: (ip) => DioService(baseUrl: ip),
    loading: () => null,
    error: (_, __) => null,
  );
});

// API Service Provider
final apiServiceProvider = Provider<ApiService?>((ref) {
  final dioService = ref.watch(dioServiceProvider);
  return dioService != null ? ApiService(dioService) : null;
});

// Transcription Repository Provider
final transcriptionRepositoryProvider = Provider<TranscriptionRepository?>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return apiService != null ? TranscriptionRepository(apiService) : null;
});

// Transcription List State
class TranscriptionListNotifier extends StateNotifier<AsyncValue<List<Transcription>>> {
  final TranscriptionRepository? _repository;

  TranscriptionListNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadTranscriptions();
  }

  Future<void> loadTranscriptions() async {
    if (_repository == null) {
      state = const AsyncValue.error('Repository not available', StackTrace.empty);
      return;
    }

    try {
      state = const AsyncValue.loading();
      
      // 先加载本地数据
      final localTranscriptions = await _repository.getLocalTranscriptions();
      state = AsyncValue.data(localTranscriptions);
      
      // 然后同步服务器数据
      await _repository.syncWithServer();
      final updatedTranscriptions = await _repository.getLocalTranscriptions();
      state = AsyncValue.data(updatedTranscriptions);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> createTranscription(String url, {bool summarize = false}) async {
    if (_repository == null) return;

    try {
      await _repository.createTranscription(url: url, summarize: summarize);
      // 创建后重新加载列表
      await loadTranscriptions();
    } catch (e) {
      // 处理错误，可以添加错误显示逻辑
      rethrow;
    }
  }

  Future<void> refreshTranscriptions() async {
    await loadTranscriptions();
  }
}

final transcriptionListProvider = StateNotifierProvider<TranscriptionListNotifier, AsyncValue<List<Transcription>>>((ref) {
  final repository = ref.watch(transcriptionRepositoryProvider);
  return TranscriptionListNotifier(repository);
});

// Selected Transcription Provider
final selectedTranscriptionProvider = StateProvider<Transcription?>((ref) => null);
