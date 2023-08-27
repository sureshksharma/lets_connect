import 'package:flutter_riverpod/flutter_riverpod.dart';

final visibleProvider = StateNotifierProvider<VisibilityNotifier, bool>((ref) {
  return VisibilityNotifier();
});

class VisibilityNotifier extends StateNotifier<bool> {
  VisibilityNotifier() : super(false);
  void toggle() {
    state = !state;
  }
}