import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/transcription.dart';

class TranscriptionView extends StatelessWidget {
  final Transcription transcription;

  const TranscriptionView({
    super.key,
    required this.transcription,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 视频信息卡片
          _buildVideoInfoCard(context),
          
          const SizedBox(height: 16),
          
          // 转录状态
          _buildStatusCard(context),
          
          const SizedBox(height: 16),
          
          // 转录内容
          if (transcription.fullText != null)
            _buildTranscriptionCard(context),
          
          const SizedBox(height: 16),
          
          // 摘要内容
          if (transcription.summaryText != null)
            _buildSummaryCard(context),
        ],
      ),
    );
  }

  Widget _buildVideoInfoCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getSourceIcon(transcription.sourceType),
                  color: _getSourceColor(transcription.sourceType),
                ),
                const SizedBox(width: 8),
                Text(
                  _getSourceName(transcription.sourceType),
                  style: TextStyle(
                    fontSize: 12,
                    color: _getSourceColor(transcription.sourceType),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              transcription.videoTitle ?? 'Unknown Title',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    transcription.originalUrl,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy, size: 16),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: transcription.originalUrl));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('链接已复制到剪贴板')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '创建时间: ${_formatDateTime(transcription.createdAt ?? DateTime.now())}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const Spacer(),
                Text(
                  '更新时间: ${_formatDateTime(transcription.updatedAt ?? DateTime.now())}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    return Card(
      color: _getStatusCardColor(transcription.status),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            _buildStatusIcon(transcription.status),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '转录状态',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _getStatusText(transcription.status),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (transcription.status == TranscriptionStatus.processing)
                    const Text(
                      '请耐心等待，转录需要一些时间...',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTranscriptionCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.text_snippet, color: Colors.blue),
                const SizedBox(width: 8),
                const Text(
                  '转录内容',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.copy, size: 20),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: transcription.fullText!));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('转录内容已复制到剪贴板')),
                    );
                  },
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            SelectableText(
              transcription.fullText!,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.summarize, color: Colors.green),
                const SizedBox(width: 8),
                const Text(
                  '内容摘要',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.copy, size: 20),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: transcription.summaryText!));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('摘要内容已复制到剪贴板')),
                    );
                  },
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            SelectableText(
              transcription.summaryText!,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon(TranscriptionStatus status) {
    switch (status) {
      case TranscriptionStatus.pending:
        return const Icon(Icons.schedule, color: Colors.orange, size: 32);
      case TranscriptionStatus.processing:
        return const SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(strokeWidth: 3),
        );
      case TranscriptionStatus.completed:
        return const Icon(Icons.check_circle, color: Colors.green, size: 32);
      case TranscriptionStatus.failed:
        return const Icon(Icons.error, color: Colors.red, size: 32);
    }
  }

  Color? _getStatusCardColor(TranscriptionStatus status) {
    switch (status) {
      case TranscriptionStatus.pending:
        return Colors.orange[50];
      case TranscriptionStatus.processing:
        return Colors.blue[50];
      case TranscriptionStatus.completed:
        return Colors.green[50];
      case TranscriptionStatus.failed:
        return Colors.red[50];
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

  IconData _getSourceIcon(SourceType sourceType) {
    switch (sourceType) {
      case SourceType.youtube:
        return Icons.play_circle_fill;
      case SourceType.bilibili:
        return Icons.video_library;
      case SourceType.other:
        return Icons.link;
    }
  }

  Color _getSourceColor(SourceType sourceType) {
    switch (sourceType) {
      case SourceType.youtube:
        return Colors.red;
      case SourceType.bilibili:
        return Colors.pink;
      case SourceType.other:
        return Colors.grey;
    }
  }

  String _getSourceName(SourceType sourceType) {
    switch (sourceType) {
      case SourceType.youtube:
        return 'YouTube';
      case SourceType.bilibili:
        return 'Bilibili';
      case SourceType.other:
        return 'Other';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
           '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
