// 应用状态定义
enum ViewState { initial, loading, data, error }

// 转录操作状态
class TranscriptionOperationState {
  final ViewState viewState;
  final String? errorMessage;
  final String? taskId;

  const TranscriptionOperationState({
    required this.viewState,
    this.errorMessage,
    this.taskId,
  });

  const TranscriptionOperationState.initial()
      : viewState = ViewState.initial,
        errorMessage = null,
        taskId = null;

  const TranscriptionOperationState.loading({this.taskId})
      : viewState = ViewState.loading,
        errorMessage = null;

  const TranscriptionOperationState.data({this.taskId})
      : viewState = ViewState.data,
        errorMessage = null;

  const TranscriptionOperationState.error(this.errorMessage, {this.taskId})
      : viewState = ViewState.error;

  TranscriptionOperationState copyWith({
    ViewState? viewState,
    String? errorMessage,
    String? taskId,
  }) {
    return TranscriptionOperationState(
      viewState: viewState ?? this.viewState,
      errorMessage: errorMessage ?? this.errorMessage,
      taskId: taskId ?? this.taskId,
    );
  }
}

// 自定义异常类
class TranscriptionException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const TranscriptionException(
    this.message, {
    this.code,
    this.originalError,
  });

  @override
  String toString() => 'TranscriptionException: $message';
}

class NetworkException extends TranscriptionException {
  const NetworkException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

class TaskFailedException extends TranscriptionException {
  const TaskFailedException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}
