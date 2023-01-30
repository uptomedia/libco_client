part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserFailure extends UserState {
  @override
  List<Object> get props => [];
}

class UserSuccess extends UserState {
  @override
  List<Object> get props => [];
}
class ProfileLoaded extends UserState {
  final UserEntity userEntity;

  ProfileLoaded({required this.userEntity});
  @override
  List<Object> get props => [userEntity];
}
class UpdateProfileLoaded extends UserState {
  // final UserEntity userEntity;

  UpdateProfileLoaded(
      // {required this.userEntity}
      );
  @override
  List<Object> get props => [
    // userEntity
  ];
}

