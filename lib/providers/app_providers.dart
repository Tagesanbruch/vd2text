import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transcription.dart';
import '../models/app_state.dart';
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

  Future<void> createTranscription(String url, {bool summarize = false, String? asrEngine}) async {
    if (_repository == null) return;

    try {
      await _repository.createTranscription(url: url, summarize: summarize, asrEngine: asrEngine);
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

// Transcription Operation State Provider
class TranscriptionOperationNotifier extends StateNotifier<TranscriptionOperationState> {
  final TranscriptionRepository? _repository;

  TranscriptionOperationNotifier(this._repository) 
      : super(const TranscriptionOperationState.initial());

  Future<void> createTranscription(String url, {bool summarize = false, bool uploadOnly = false, String? asrEngine}) async {
    if (_repository == null) {
      state = const TranscriptionOperationState.error('服务不可用，请检查设置');
      return;
    }

    try {
      state = const TranscriptionOperationState.loading();
      
      final taskInfo = await _repository.createTranscription(url: url, summarize: summarize, asrEngine: asrEngine);
      
      if (uploadOnly) {
        // 仅上传模式，直接标记为完成
        state = TranscriptionOperationState.data(taskId: taskInfo.taskId);
      } else {
        // 开始轮询任务状态
        state = TranscriptionOperationState.loading(taskId: taskInfo.taskId);
        await _pollTaskStatus(taskInfo.taskId);
      }
    } on TranscriptionException catch (e) {
      state = TranscriptionOperationState.error(e.message);
    } catch (e) {
      state = TranscriptionOperationState.error('创建转录任务失败: $e');
    }
  }

  Future<void> _pollTaskStatus(String taskId) async {
    // 轮询间隔（秒）
    const pollInterval = Duration(seconds: 5);
    const maxAttempts = 120; // 最多轮询10分钟
    
    int attempts = 0;
    
    while (attempts < maxAttempts) {
      try {
        await Future.delayed(pollInterval);
        
        final transcription = await _repository!.getTranscriptionDetails(taskId);
        
        if (transcription != null) {
          switch (transcription.status) {
            case TranscriptionStatus.completed:
              state = TranscriptionOperationState.data(taskId: taskId);
              return;
            case TranscriptionStatus.failed:
              state = TranscriptionOperationState.error(
                '转录失败，请重试',
                taskId: taskId,
              );
              return;
            case TranscriptionStatus.processing:
            case TranscriptionStatus.pending:
              // 继续轮询
              break;
          }
        }
        
        attempts++;
      } catch (e) {
        // 网络错误时稍微延长间隔再试
        await Future.delayed(const Duration(seconds: 2));
        attempts++;
      }
    }
    
    // 轮询超时
    state = TranscriptionOperationState.error(
      '转录处理超时，请稍后手动刷新查看结果',
      taskId: taskId,
    );
  }

  void reset() {
    state = const TranscriptionOperationState.initial();
  }
}

final transcriptionOperationProvider = StateNotifierProvider<TranscriptionOperationNotifier, TranscriptionOperationState>((ref) {
  final repository = ref.watch(transcriptionRepositoryProvider);
  return TranscriptionOperationNotifier(repository);
});
