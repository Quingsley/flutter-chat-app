import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/features/auth/data/models/user_model.dart';
import 'package:ui/features/auth/data/remote_data_source/remote_data_source.dart';
import 'package:ui/shared/providers/shared_providers.dart';

class HomeVm {
  final RemoteDataSource dataSource;

  HomeVm({required this.dataSource});

  Future<List<User>> getContacts(String email) async {
    var contacts = await dataSource.getContacts(email);
    return contacts;
  }
}

final homeVmProvider = Provider((ref) {
  final dataSource = ref.read(remoteDataSourceProvider);
  return HomeVm(dataSource: dataSource);
});
