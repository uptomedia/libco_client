import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    final String? name,
    final String? email,
    final String? uid,
    final String? status,
    final String? password,
    final String? imageString64,

  }) : super(
            uid: uid,
            name: name,
            email: email,
            password: password,
            status: status,
  imageString64: imageString64);

  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      status: (documentSnapshot.data() as Map)['status']??"",
      name: (documentSnapshot.data() as Map)['name']??"",
      uid: (documentSnapshot.data() as Map)['uid']??"",
      email:(documentSnapshot.data() as Map)['email']??"",
      imageString64: (documentSnapshot.data() as Map)['imageString64']??"",
    );
  }

  Map<String, dynamic> toDocument() {
    return {"status": status, "uid": uid, "email": email,"password":password,"imageString64":imageString64,
      "name": name,};
  }
}
