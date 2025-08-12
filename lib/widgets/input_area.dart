import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_providers.dart';
import '../models/transcription.dart';

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
  AsrEngine _selectedAsrEngine = AsrEngine.whisper;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -4),
            blurRadius: 12,
            color: Colors.black.withValues(alpha: 0.1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 选项开关
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                // 第一行：生成摘要和仅上传选项
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: _summarize,
                            onChanged: (value) {
                              setState(() {
                                _summarize = value ?? false;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '生成摘要',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  '使用AI生成内容摘要',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: _uploadOnly,
                            onChanged: (value) {
                              setState(() {
                                _uploadOnly = value ?? false;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '仅上传',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  '后台处理，稍后查看',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
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
                
                const SizedBox(height: 12),
                
                // 分割线
                Container(
                  height: 1,
                  color: Colors.grey.withOpacity(0.2),
                ),
                
                const SizedBox(height: 12),
                
                // 第二行：ASR引擎选择器
                Row(
                  children: [
                    Icon(
                      Icons.settings_voice,
                      size: 20,
                      color: Colors.grey[700],
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'ASR引擎:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<AsrEngine>(
                            value: _selectedAsrEngine,
                            isExpanded: true,
                            onChanged: (AsrEngine? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _selectedAsrEngine = newValue;
                                });
                              }
                            },
                            items: [
                              DropdownMenuItem<AsrEngine>(
                                value: AsrEngine.whisper,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text('Whisper'),
                                    const Spacer(),
                                    Text(
                                      '准确',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              DropdownMenuItem<AsrEngine>(
                                value: AsrEngine.gemini,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text('Gemini'),
                                    const Spacer(),
                                    Text(
                                      '智能',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              DropdownMenuItem<AsrEngine>(
                                value: AsrEngine.funAsr,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: const BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text('FunASR'),
                                    const Spacer(),
                                    Text(
                                      '快速',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 输入区域
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _urlController,
                  decoration: InputDecoration(
                    hintText: '输入视频链接 (YouTube, Bilibili 等) 或 BV号',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    prefixIcon: Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.link,
                        size: 20,
                        color: Colors.blue,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  keyboardType: TextInputType.url,
                  enabled: !_isLoading,
                  onSubmitted: (_) => _submitTranscription(),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                height: 56,
                decoration: BoxDecoration(
                  gradient: _isLoading 
                    ? null 
                    : LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withOpacity(0.8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                  color: _isLoading ? Colors.grey[300] : null,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: _isLoading ? null : [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitTranscription,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.send,
                              size: 20,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              '发送',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
          
          // 状态提示
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '正在提交转录任务...',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
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
      _showErrorSnackBar('请输入有效的URL或BV号');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // 获取ASR引擎的字符串值
      String asrEngineValue;
      switch (_selectedAsrEngine) {
        case AsrEngine.whisper:
          asrEngineValue = 'whisper';
          break;
        case AsrEngine.gemini:
          asrEngineValue = 'gemini';
          break;
        case AsrEngine.funAsr:
          asrEngineValue = 'funasr';
          break;
      }
      
      // 使用新的状态管理器
      await ref.read(transcriptionOperationProvider.notifier)
          .createTranscription(
            url, 
            summarize: _summarize, 
            uploadOnly: _uploadOnly,
            asrEngine: asrEngineValue,
          );
      
      // 清空输入框
      _urlController.clear();
      
      // 显示成功提示
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(
                  _uploadOnly ? Icons.cloud_upload : Icons.auto_awesome,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _uploadOnly ? '任务已提交!' : '转录已开始!',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _uploadOnly 
                          ? '您可以稍后回来查看结果' 
                          : '正在处理中，预计需要几分钟时间',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green[600],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            margin: const EdgeInsets.all(16),
            duration: const Duration(seconds: 4),
          ),
        );
      }
      
      // 刷新转录列表
      ref.read(transcriptionListProvider.notifier).refreshTranscriptions();
      
    } catch (e) {
      _showErrorSnackBar('提交失败: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  bool _isValidUrl(String url) {
    // 检查是否为BV号
    if (_isBvNumber(url)) {
      return true;
    }
    
    // 检查是否为有效URL
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  bool _isBvNumber(String input) {
    // BV号格式: BV开头，后面跟10位字符（数字和字母）
    final bvRegex = RegExp(r'^BV[1-9a-km-zA-HJ-NP-Z]{10}$');
    return bvRegex.hasMatch(input.trim());
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '提交失败',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      message,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red[600],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }
}
