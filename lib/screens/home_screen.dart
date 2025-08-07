import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_providers.dart';
import '../widgets/history_drawer.dart';
import '../widgets/input_area.dart';
import '../widgets/transcription_view.dart';
import 'settings_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTranscription = ref.watch(selectedTranscriptionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SyncTranscribe'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(transcriptionListProvider.notifier).refreshTranscriptions();
            },
          ),
        ],
      ),
      drawer: const HistoryDrawer(),
      body: Column(
        children: [
          // 主要内容区域
          Expanded(
            child: selectedTranscription != null
                ? TranscriptionView(transcription: selectedTranscription)
                : _buildEmptyState(context),
          ),
          // 底部输入区域
          const InputArea(),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.text_snippet_outlined,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            '选择一个转录记录查看',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '或者在下方输入视频链接开始新的转录',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
