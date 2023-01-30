import 'dart:async';
import 'dart:convert';

import 'package:chegg/features/data/remote/models/currency_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gallery_saver/files.dart';

import '../../../domain/entities/currency_rate_entity.dart';
import '../../../domain/entities/exchange_currency_entity.dart';
import '../../../domain/entities/provider_entity.dart';
 import '../../../domain/entities/transfer_info_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../models/exchange_currency_model.dart';
import '../models/transfer_info_model.dart';
import '../models/user_model.dart';
import '../models/provider_model.dart';
import 'firebase_remote_data_source.dart';
import 'package:http/http.dart' as http;


class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseRemoteDataSourceImpl({required this.auth, required this.firestore});

  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signIn(UserEntity user) async => auth.signInWithEmailAndPassword(
      email: user.email!, password: user.password!);

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> signUp(UserEntity user) async =>
      auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async{
    final userCollectionRef = firestore.collection("users");
    final uid=await getCurrentUId();
    userCollectionRef.doc(uid).get().then((value){
      final newUser=UserModel(
        uid:uid ,
        status: user.status,
        email: user.email,
        name: user.name,
      ).toDocument();
      if (!value.exists){
        userCollectionRef.doc(uid).set(newUser);
      }
      return;
    });

  }
  @override
  Stream<List<ProviderEntity>> getProvider() {
    final providerCollectionRef=firestore.collection("provider");

  return providerCollectionRef.snapshots().map(
        (querySnap) {
      return querySnap.docs.map((docSnap) =>
          ProviderModel.fromSnapshot(docSnap)).toList();
    });



  }
  @override
  Future<void> addNewProvider(ProviderEntity noteEntity) async{
    final noteCollectionRef =
    firestore.collection("provider");

    final noteId = noteCollectionRef.doc().id;

    noteCollectionRef.doc(noteId).get().then((note) {
      final newNote = ProviderModel(
        imagePath: noteEntity.imagePath,
        name: noteEntity.name,
        providerId: noteId
      ).toDocument();

      if (!note.exists) {

        noteCollectionRef.doc(noteId).set(newNote);

      }
      return;
    });
  }

  @override
  Future<void> deleteProvider(ProviderEntity noteEntity)async {
    final noteCollectionRef =
    // firestore.collection("provider").doc(noteEntity.providerId).collection("notes");
    firestore.collection("provider");


    noteCollectionRef.doc(noteEntity.providerId).get().then((note) {
      if (note.exists){
        noteCollectionRef.doc(noteEntity. providerId).delete();
      }
      return;
    });

  }

  @override
  Future<void> updateProvider(ProviderEntity note)async {
    Map<String,dynamic> noteMap=Map();
    final noteCollectionRef=firestore.collection("provider") ;

    if (note.name!=null) noteMap['name']=note.name;
    if (note.imagePath!=null) noteMap['imagePath'] =note.imagePath;

    noteCollectionRef.doc(note.providerId).update(noteMap);
  }

  @override
  Future<void> updateProfile(UserEntity note) async {
     Map<String,dynamic> noteMap=Map();
    final noteCollectionRef=firestore.collection("users") ;

    if (note.name!=null) noteMap['name']=note.name;
    if (note.password!=null) noteMap['password'] =note.password;
    if (note.email!=null) noteMap['email'] =note.email;
    if (note.imageString64!=null) noteMap['imageString64'] =note.imageString64;
    if (note.uid!=null) noteMap['uid'] =note.uid;
    if (note.status!=null) noteMap['status'] =note.status;

    noteCollectionRef.doc(note.uid).set(noteMap,SetOptions(merge: true));
  }

  @override
  Future<UserEntity> getProfile(String uid) async {
    DocumentSnapshot noteCollectionRef=
      await firestore.collection("users").doc(uid).get() ;
    return UserModel.fromSnapshot(noteCollectionRef);
 }
 @override
  Future<CurrencyRateEntity> getCurrencyRate(String code) async {
   // final body = {
   //   'username': username,
   //   'password': password,
   // };
    final response = await http.get(
     Uri.parse('https://api.freecurrencyapi.com/v1/latest?base_currency=USD'),
     // body: body,
     headers: {
       "apikey":"4AxOelGEzoPKxLTjZ8saf4jtas519A7zy0Sj9rfW"
     }
   );
   return  CurrencyRateModel.fromJson(
       json.decode(response.body));

 }

  @override
  Future<void> addNewTransferInfo(TransferInfoEntity noteEntity) async{
    final noteCollectionRef =
    firestore.collection("transferInfo");

    final noteId = noteCollectionRef.doc().id;

    noteCollectionRef.doc(noteId).get().then((note) {
      final newTransferInfo = TransferInfo(
          userName: noteEntity.userName,
          receiveAmount: noteEntity.receiveAmount,
        exchangeRate: noteEntity.exchangeRate,
        paymentCurrency: noteEntity.paymentCurrency,

           recieveCurrency:noteEntity.recieveCurrency,
          sendAmount:noteEntity.sendAmount,
          totalRecieveAmount:noteEntity.totalRecieveAmount,
          promotionCode:noteEntity.promotionCode,
          promotionRate:noteEntity.promotionRate
       ).toDocument();

      if (!note.exists) {

        noteCollectionRef.doc(noteId).set(newTransferInfo);

      }
      return;
    });
  }


  @override
  Stream<List<TransferInfoEntity>> getTransferInfo() {
    final providerCollectionRef=firestore.collection("transferInfo");

    return providerCollectionRef.snapshots().map(
            (querySnap) {
          return querySnap.docs.map((docSnap) =>
              TransferInfo.fromSnapshot(docSnap)).toList();
        });



  }
  @override
  Stream<List<ExchangeCurrencyEntity>> getExchangeCurrency(String code)   {

    final noteCollectionRef =
    firestore.collection("exchangeCurreny") ;


    return noteCollectionRef.snapshots().map((querySnap  ) {
      return querySnap.docs.map((docSnap  ) =>
          ExchangeCurrencyModel.fromSnapshot(docSnap)).toList();
    });

  }
}
