import 'package:riverpod/riverpod.dart';

class SelectedStyleNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setStyle(String? style) {
    state = style;
  }
}

final selectedStyleProvider = NotifierProvider<SelectedStyleNotifier, String?>(() => SelectedStyleNotifier());