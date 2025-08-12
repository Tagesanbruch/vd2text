import 'dart:convert';
import 'lib/models/transcription.dart';

void main() {
  // 测试ASR引擎枚举
  print('Testing ASR Engine enum...');
  
  // 测试枚举值
  for (var engine in AsrEngine.values) {
    print('Engine: $engine');
  }
  
  // 测试TranscriptionCreate序列化
  print('\nTesting TranscriptionCreate serialization...');
  
  final create1 = TranscriptionCreate(
    url: 'https://example.com/video',
    summarize: true,
    asrEngine: 'whisper',
  );
  
  final create2 = TranscriptionCreate(
    url: 'https://example.com/video',
    summarize: false,
    asrEngine: 'gemini',
  );
  
  final create3 = TranscriptionCreate(
    url: 'https://example.com/video',
    summarize: true,
    asrEngine: 'funasr',
  );
  
  print('Whisper request: ${jsonEncode(create1.toJson())}');
  print('Gemini request: ${jsonEncode(create2.toJson())}');
  print('FunASR request: ${jsonEncode(create3.toJson())}');
  
  print('\nASR Engine test completed successfully!');
}
