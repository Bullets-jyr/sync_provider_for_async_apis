import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'main.dart';

part 'counter_provider.g.dart';

@riverpod
class Counter extends _$Counter {
  @override
  int build() {
    final preferences = ref.watch(sharedPreferencesProvider);
    final currentValue = preferences.getInt('counter') ?? 0;

    // CounterProvider 자체에 대한 listener를 등록시켜서 counter값이 변할 때 마다
    // sharedPreferences에 변한 값을 기록하겠습니다.
    // 자기 자신을 listen
    // state가 변할 때 마다 호출이 됩니다.
    ref.listenSelf((previous, next) {
      print('previous: $previous, next: $next');
      preferences.setInt('counter', next);
    });

    return currentValue;
  }

  void increment() {
    state++;
  }
}