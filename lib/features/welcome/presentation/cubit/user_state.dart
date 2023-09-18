part of 'user_cubit.dart';

@immutable
sealed class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoadedState extends UserState {
  final String username;

  UserLoadedState({required this.username});
}

final class UserErrorState extends UserState {
  UserErrorState(this.message);
  final String message;
}
