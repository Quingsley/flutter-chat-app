import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/features/auth/data/models/user_model.dart';
import 'package:ui/services/socket.dart';
import 'package:ui/shared/providers/shared_providers.dart';

class WelcomeViewModel extends AsyncNotifier<User?> {
  Future<void> signIn(String email) async {
    final dataSource = ref.read(remoteDataSourceProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => dataSource.signIn(email));
  }

  Future<void> signUp(String userName, String email) async {
    final dataSource = ref.read(remoteDataSourceProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => dataSource.signUp(userName, email));
  }

  void connect() {
    ref.read(socketProvider.notifier).connectUser();
  }

  @override
  FutureOr<User?> build() {
    return state.value;
  }
}

final authControllerProvider =
    AsyncNotifierProvider<WelcomeViewModel, User?>(WelcomeViewModel.new);
