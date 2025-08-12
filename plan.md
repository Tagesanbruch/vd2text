### **【前端】下一步开发方案 (for Cursor AI)**

**overarching goal:** 优化 UI/UX 细节，增强状态管理的健壮性，提供更明确的用户反馈。

#### **任务一：转录详情卡片 UI 美化**

* **目标**: 基于当前截图，优化信息展示的布局和视觉层级。
* **文件**: 负责显示转录详情的 Widget (例如，您可以创建一个 `transcription_card.dart`)。
* **操作**:
  1. **增加间距**:
     * 在 `Card` 的 `child` 外层包裹一个 `Padding` Widget，例如 `padding: const EdgeInsets.all(16.0)`。
     * 在标题、链接、状态框、内容框等垂直元素之间使用 `SizedBox(height: 12.0)` 来增加垂直间距。
  2. **强化视觉层级**:
     * **标题**: 使用 `Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold))`。
     * **链接**: 使用不同的颜色，并考虑用 `url_launcher` 包使其可以点击。
     * **创建/更新时间**: 使用更小、颜色更浅的字体，例如 `style: Theme.of(context).textTheme.labelSmall`。
  3. **美化组件**:
     * **状态框**: 给 `Container` 增加圆角 `borderRadius: BorderRadius.circular(8.0)` 和一个柔和的背景色，例如 `Colors.green.withOpacity(0.1)`。
     * **卡片本身**: 确保 `Card` 组件有适当的 `elevation` 和 `shape` (如 `RoundedRectangleBorder`) 来产生悬浮感。

#### **任务二：实现加载与错误状态处理**

* **目标**: 为用户提供清晰的过程反馈，并能优雅地处理异常。
* **文件**: `home_screen.dart`, `transcription_repository.dart`, 以及相关的 Riverpod `Notifier`。
* **操作**:
  1. **定义状态**: 在您的 Riverpod `StateNotifier` 中，定义一个包含加载、成功、失败等状态的 `State` 对象或 `enum`。
     ```dart
     enum ViewState { initial, loading, data, error }
     ```
  2. **处理加载状态**:
     * 当用户点击“发送”且未勾选“仅上传”时，将 Notifier 的状态设置为 `loading`。
     * 在 `home_screen.dart` 中，`watch` 这个状态。当状态为 `loading` 时，在内容区域显示一个 `CircularProgressIndicator` 和提示文本，例如 "正在转录中，请稍候..."。
  3. **处理错误状态**:
     * 在 `transcription_repository.dart` 的 API 调用方法中，使用 `try...catch` 捕获 `DioException` 等网络错误。如果捕获到错误，向上抛出一个自定义的异常。
     * 在 `Notifier` 中，捕获这个自定义异常，并将状态设置为 `error`，同时保存错误信息。
     * 在 `home_screen.dart` 中，当状态为 `error` 时，显示一个友好的错误提示 Widget，例如 `Text("请求失败：${error.message}")`。
  4. **处理后端任务失败**: 当轮询后端任务，发现返回的 `status` 字段为 `FAILED` 时，同样将状态切换为 `error`，并显示后端传回的错误信息。

#### **任务三：增加交互反馈**

* **目标**: 让用户的操作得到即时、明确的响应。
* **文件**: 所有包含用户交互（如按钮点击）的 Widget。
* **操作**:
  1. **复制反馈**: 在转录内容卡片的复制按钮的 `onPressed` 回调中，当复制成功后，调用 `ScaffoldMessenger` 来显示一个 `SnackBar`。
     ```dart
     Clipboard.setData(ClipboardData(text: transcriptionText)).then((_) {
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('已复制到剪贴板!')),
       );
     });
     ```
  2. **提交反馈**: 在点击“发送”按钮，成功提交任务到后端后，也可以弹出一个 `SnackBar` 提示“任务已提交”，特别是对于“仅上传”模式，这能给用户一个确切的反馈。
