import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transcription_new.g.dart';

@JsonEnum()
enum TranscriptionStatus {
  @JsonValue("PENDING")
  pending,
  @JsonValue("PROCESSING")
  processing,
  @JsonValue("COMPLETED")
  completed,
  @JsonValue("FAILED")
  failed,
}

@JsonEnum()
enum SourceType {
  @JsonValue("YOUTUBE")
  youtube,
  @JsonValue("BILIBILI")
  bilibili,
  @JsonValue("OTHER")
  other,
}

@Collection()
@JsonSerializable()
class Transcription {
  Id id = Isar.autoIncrement;
  
  @Index(unique: true)
  @JsonKey(name: 'id')
  String remoteId = '';
  
  @JsonKey(name: 'video_title')
  String? videoTitle;
  
  @JsonKey(name: 'original_url')
  String originalUrl = '';
  
  @JsonKey(name: 'source_type')
  @Enumerated(EnumType.name)
  SourceType sourceType = SourceType.other;
  
  @JsonKey(name: 'full_text')
  String? fullText;
  
  @JsonKey(name: 'summary_text')
  String? summaryText;
  
  @Enumerated(EnumType.name)
  TranscriptionStatus status = TranscriptionStatus.pending;
  
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  Transcription();

  factory Transcription.fromJson(Map<String, dynamic> json) => _$TranscriptionFromJson(json);
  Map<String, dynamic> toJson() => _$TranscriptionToJson(this);
}

@JsonSerializable()
class TaskInfo {
  @JsonKey(name: 'task_id')
  final String taskId;
  
  final String status;

  TaskInfo({
    required this.taskId,
    required this.status,
  });

  factory TaskInfo.fromJson(Map<String, dynamic> json) => _$TaskInfoFromJson(json);
  Map<String, dynamic> toJson() => _$TaskInfoToJson(this);
}

@JsonSerializable()
class TranscriptionCreate {
  final String url;
  final bool summarize;

  TranscriptionCreate({
    required this.url,
    this.summarize = false,
  });

  factory TranscriptionCreate.fromJson(Map<String, dynamic> json) => _$TranscriptionCreateFromJson(json);
  Map<String, dynamic> toJson() => _$TranscriptionCreateToJson(this);
}
