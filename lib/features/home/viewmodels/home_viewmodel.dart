import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/features/auth/data/models/user_model.dart';
import 'package:ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:ui/shared/providers/shared_providers.dart';

class HomeVm extends AsyncNotifier<void> {
  Future<List<User>> getContacts(String email) async {
    var dataSource = ref.read(remoteDataSourceProvider);
    var contacts = await dataSource.getContacts(email);

    //update the List of chats
    for (var contact in contacts) {
      for (var chat in contact.chats) {
        ref.read(chatListProvider.notifier).addChat(chat);
      }
    }

    return contacts;
  }

  @override
  FutureOr<void> build() {}
}

final homeVmProvider = AsyncNotifierProvider<HomeVm, void>(HomeVm.new);
