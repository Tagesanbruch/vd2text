import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/transcription.dart';

class IsarService {
  static IsarService? _instance;
  static Isar? _isar;

  IsarService._();

  static IsarService get instance {
    _instance ??= IsarService._();
    return _instance!;
  }

  static Future<Isar> get isar async {
    if (_isar == null) {
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open(
        [TranscriptionSchema],
        directory: dir.path,
      );
    }
    return _isar!;
  }

  Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }
}
