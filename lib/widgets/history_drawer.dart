import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/transcription.dart';
import '../providers/app_providers.dart';
import '../screens/settings_screen.dart';

class HistoryDrawer extends ConsumerWidget {
  const HistoryDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transcriptionListAsync = ref.watch(transcriptionListProvider);
    final selectedTranscription = ref.watch(selectedTranscriptionProvider);

    return Drawer(
      child: Column(
        children: [
          // 抽屉头部
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.history,
                  color: Colors.white,
                  size: 32,
                ),
                SizedBox(height: 8),
                Text(
                  '转录历史',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // 转录列表
          Expanded(
            child: transcriptionListAsync.when(
              data: (transcriptions) {
                if (transcriptions.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 48,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          '暂无转录记录',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: transcriptions.length,
                  itemBuilder: (context, index) {
                    final transcription = transcriptions[index];
                    final isSelected = selectedTranscription?.remoteId == transcription.remoteId;

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      elevation: isSelected ? 4 : 1,
                      color: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
                      child: ListTile(
                        leading: _buildStatusIcon(transcription.status),
                        title: Text(
                          transcription.videoTitle ?? 'Unknown Title',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getStatusText(transcription.status),
                              style: TextStyle(
                                color: _getStatusColor(transcription.status),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              _formatDate(transcription.updatedAt ?? DateTime.now()),
                              style: const TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                        onTap: () {
                          ref.read(selectedTranscriptionProvider.notifier).state = transcription;
                          Navigator.pop(context); // 关闭抽屉
                        },
                        trailing: transcription.status == TranscriptionStatus.completed
                            ? const Icon(Icons.check_circle, color: Colors.green)
                            : null,
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '加载失败',
                      style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(transcriptionListProvider.notifier).refreshTranscriptions();
                      },
                      child: const Text('重试'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // 底部设置按钮
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('设置'),
            onTap: () {
              Navigator.pop(context); // 关闭抽屉
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(TranscriptionStatus status) {
    switch (status) {
      case TranscriptionStatus.pending:
        return const Icon(Icons.schedule, color: Colors.orange);
      case TranscriptionStatus.processing:
        return const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        );
      case TranscriptionStatus.completed:
        return const Icon(Icons.check_circle, color: Colors.green);
      case TranscriptionStatus.failed:
        return const Icon(Icons.error, color: Colors.red);
    }
  }

  String _getStatusText(TranscriptionStatus status) {
    switch (status) {
      case TranscriptionStatus.pending:
        return '等待处理';
      case TranscriptionStatus.processing:
        return '正在转录';
      case TranscriptionStatus.completed:
        return '转录完成';
      case TranscriptionStatus.failed:
        return '转录失败';
    }
  }

  Color _getStatusColor(TranscriptionStatus status) {
    switch (status) {
      case TranscriptionStatus.pending:
        return Colors.orange;
      case TranscriptionStatus.processing:
        return Colors.blue;
      case TranscriptionStatus.completed:
        return Colors.green;
      case TranscriptionStatus.failed:
        return Colors.red;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}天前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}小时前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }
}
