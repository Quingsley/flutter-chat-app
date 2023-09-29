import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/features/add/data/datasource/add_contact_data_source.dart';
import 'package:ui/features/add/data/models/new_contact_model.dart';
import 'package:ui/services/socket.dart';
import 'package:ui/shared/providers/shared_providers.dart';

class AddVM extends AsyncNotifier<bool> {
  Future<void> addContact(String contactEmail) async {
    var currentUser = ref.read(currentUserProvider);
    var dataSource = ref.read(addContactDataSourceProvider);
    NewContactModel contact = NewContactModel(
        userEmail: currentUser!.email, newContactEmail: contactEmail);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => dataSource.addContact(contact));
    if (state.value != null && state.value == true) {
      ref.read(socketProvider.notifier).newContactAdded(contact);
    }
  }

  @override
  FutureOr<bool> build() {
    return state.value!;
  }
}

final addVmProvider = AsyncNotifierProvider<AddVM, bool>(AddVM.new);
