import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/features/home/viewmodels/home_viewmodel.dart';
import 'package:ui/features/auth/data/models/user_model.dart';
import 'package:ui/features/auth/data/remote_data_source/remote_data_source.dart';
import 'package:http/http.dart' as http;

final remoteDataSourceProvider = Provider<RemoteDataSource>((ref) {
  final client = ref.watch(httpProvider);
  return RemoteDataSource(client: client);
});

//currently logged in user
final currentUserProvider = StateProvider<User?>((ref) {
  return null;
});

final httpProvider = Provider<http.Client>((ref) {
  return http.Client();
});

final contactsFutureProvider = FutureProvider.family((ref, String email) {
  var homeVm = ref.watch(homeVmProvider);
  return homeVm.getContacts(email);
});
