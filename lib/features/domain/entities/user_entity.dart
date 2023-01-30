import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  late String? name;
  late String? email;
  late String? uid;
  late String? status;
  late String? password;
  late   String? imageString64;

  UserEntity({
    this.name,
    this.email,
    this.uid,
    this.status = "Hello there i'm using this app",
    this.password,
    this.imageString64
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        email,
        uid,
        status,
        password,
    imageString64
      ];
}
