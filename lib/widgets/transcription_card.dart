import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/transcription.dart';

class TranscriptionCard extends StatelessWidget {
  final Transcription transcription;

  const TranscriptionCard({
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
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 来源标签
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _getSourceColor(transcription.sourceType).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Icon(
                    _getSourceIcon(transcription.sourceType),
                    color: _getSourceColor(transcription.sourceType),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getSourceColor(transcription.sourceType).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: _getSourceColor(transcription.sourceType).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    _getSourceName(transcription.sourceType),
                    style: TextStyle(
                      fontSize: 13,
                      color: _getSourceColor(transcription.sourceType),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // 视频标题
            Text(
              transcription.videoTitle ?? 'Unknown Title',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                height: 1.3,
                letterSpacing: -0.5,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 链接区域
            InkWell(
              onTap: () => _launchUrl(transcription.originalUrl),
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.05),
                      Colors.blue.withOpacity(0.02),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Colors.blue.withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.link,
                        size: 18,
                        color: Colors.blue[700],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '原始链接',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            transcription.originalUrl,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.blue[700],
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue[700],
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.copy,
                          size: 18,
                          color: Colors.grey[700],
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                        onPressed: () => _copyToClipboard(
                          context,
                          transcription.originalUrl,
                          '链接已复制到剪贴板!',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 时间信息
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.04),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '创建时间',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDateTime(transcription.createdAt ?? DateTime.now()),
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 32,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.update,
                              size: 14,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '更新时间',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDateTime(transcription.updatedAt ?? DateTime.now()),
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _getStatusCardColor(transcription.status) ?? Colors.grey.withOpacity(0.1),
              (_getStatusCardColor(transcription.status) ?? Colors.grey.withOpacity(0.1)).withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: _buildStatusIcon(transcription.status),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '转录状态',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _getStatusText(transcription.status),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: _getStatusTextColor(transcription.status),
                      ),
                    ),
                    if (transcription.status == TranscriptionStatus.processing) ...[
                      const SizedBox(height: 6),
                      Text(
                        '预计还需要几分钟时间',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTranscriptionCard(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.withOpacity(0.15),
                        Colors.blue.withOpacity(0.08),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Icon(
                    Icons.text_snippet,
                    color: Colors.blue,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    '转录内容',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.copy, size: 22),
                    color: Colors.grey[700],
                    onPressed: () => _copyToClipboard(
                      context,
                      transcription.fullText!,
                      '转录内容已复制到剪贴板!',
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.04),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: SelectableText(
                transcription.fullText!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.purple.withOpacity(0.15),
                        Colors.purple.withOpacity(0.08),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.purple,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'AI 摘要',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.copy, size: 22),
                    color: Colors.grey[700],
                    onPressed: () => _copyToClipboard(
                      context,
                      transcription.summaryText!,
                      '摘要内容已复制到剪贴板!',
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.03),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.purple.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: SelectableText(
                transcription.summaryText!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  fontSize: 15,
                ),
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
        return Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Icon(Icons.schedule, color: Colors.orange, size: 24),
        );
      case TranscriptionStatus.processing:
        return Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2.5),
          ),
        );
      case TranscriptionStatus.completed:
        return Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Icon(Icons.check_circle, color: Colors.green, size: 24),
        );
      case TranscriptionStatus.failed:
        return Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Icon(Icons.error, color: Colors.red, size: 24),
        );
    }
  }

  Color? _getStatusCardColor(TranscriptionStatus status) {
    switch (status) {
      case TranscriptionStatus.pending:
        return Colors.orange.withOpacity(0.08);
      case TranscriptionStatus.processing:
        return Colors.blue.withOpacity(0.08);
      case TranscriptionStatus.completed:
        return Colors.green.withOpacity(0.08);
      case TranscriptionStatus.failed:
        return Colors.red.withOpacity(0.08);
    }
  }

  Color _getStatusTextColor(TranscriptionStatus status) {
    switch (status) {
      case TranscriptionStatus.pending:
        return Colors.orange[700]!;
      case TranscriptionStatus.processing:
        return Colors.blue[700]!;
      case TranscriptionStatus.completed:
        return Colors.green[700]!;
      case TranscriptionStatus.failed:
        return Colors.red[700]!;
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

  Future<void> _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // 处理错误
    }
  }

  void _copyToClipboard(BuildContext context, String text, String message) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(message),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
    });
  }
}
