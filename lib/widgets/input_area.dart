import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_providers.dart';

class InputArea extends ConsumerStatefulWidget {
  const InputArea({super.key});

  @override
  ConsumerState<InputArea> createState() => _InputAreaState();
}

class _InputAreaState extends ConsumerState<InputArea> {
  final TextEditingController _urlController = TextEditingController();
  bool _isLoading = false;
  bool _summarize = false;
  bool _uploadOnly = false;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            blurRadius: 4,
            color: Colors.black.withValues(alpha: 0.1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 选项开关
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: const Text('生成摘要'),
                  subtitle: const Text('使用AI生成视频内容摘要'),
                  value: _summarize,
                  onChanged: (value) {
                    setState(() {
                      _summarize = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: true,
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: const Text('仅上传'),
                  subtitle: const Text('只提交任务，不等待完成'),
                  value: _uploadOnly,
                  onChanged: (value) {
                    setState(() {
                      _uploadOnly = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: true,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // 输入区域
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _urlController,
                  decoration: const InputDecoration(
                    hintText: '输入视频链接 (YouTube, Bilibili 等)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.link),
                  ),
                  keyboardType: TextInputType.url,
                  enabled: !_isLoading,
                  onSubmitted: (_) => _submitTranscription(),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitTranscription,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('发送'),
              ),
            ],
          ),
          
          // 状态提示
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                '正在提交转录任务...',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _submitTranscription() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      _showErrorSnackBar('请输入视频链接');
      return;
    }

    // 简单的URL验证
    if (!_isValidUrl(url)) {
      _showErrorSnackBar('请输入有效的URL');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await ref.read(transcriptionListProvider.notifier)
          .createTranscription(url, summarize: _summarize);
      
      // 清空输入框
      _urlController.clear();
      
      // 显示成功提示
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_uploadOnly ? '任务已提交' : '转录任务已创建，正在处理中...'),
            backgroundColor: Colors.green,
          ),
        );
      }
      
      // 如果不是仅上传模式，可以在这里添加轮询逻辑
      if (!_uploadOnly) {
        _startPollingStatus();
      }
      
    } catch (e) {
      _showErrorSnackBar('提交失败: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _startPollingStatus() {
    // 这里可以实现轮询任务状态的逻辑
    // 暂时简单地刷新列表
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        ref.read(transcriptionListProvider.notifier).refreshTranscriptions();
      }
    });
  }

  bool _isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
