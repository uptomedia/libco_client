import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/transfer_info_entity.dart';
import '../../../domain/entities/user_entity.dart';

class TransferInfo   extends TransferInfoEntity {
  TransferInfo({
    final String? userName,
    final String? UId,
    final double? receiveAmount,
    final double? exchangeRate,
    final String? paymentCurrency,
    final String? recieveCurrency,
    final double? sendAmount,
    final double? totalRecieveAmount,
    final double? promotionRate,
    final String?  promotionCode,}) : super(
      userName: userName,
    UId: UId,
      receiveAmount:receiveAmount,
      exchangeRate: exchangeRate,
      paymentCurrency:paymentCurrency,
    recieveCurrency:recieveCurrency,
    sendAmount:sendAmount,
    totalRecieveAmount:totalRecieveAmount,
    promotionCode:promotionCode,
    promotionRate:promotionRate,
  );


  factory TransferInfo.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return TransferInfo(
      userName:(documentSnapshot.data() as Map)['userName']??"",
       //documentSnapshot.get('userName')??"",
        UId:(documentSnapshot.data() as Map)['UId']??"",
       receiveAmount:(documentSnapshot.data() as Map)['receiveAmount']??0,
      exchangeRate:(documentSnapshot.data() as Map)['exchangeRate']??0,
      paymentCurrency: (documentSnapshot.data() as Map)['paymentCurrency']??"USD",
      sendAmount:(documentSnapshot.data() as Map)['sendAmount']??0,
      totalRecieveAmount:(documentSnapshot.data() as Map)['totalRecieveAmount']??0,
      promotionCode: (documentSnapshot.data() as Map)['promotionCode']??"",
      promotionRate: (documentSnapshot.data() as Map)['promotionRate']??0,

    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "userName": this.userName,
      "UId": this.UId,
      "receiveAmount": this.receiveAmount,
      "exchangeRate": this.exchangeRate,
      "paymentCurrency": this.paymentCurrency,
      "recieveCurrency": this.recieveCurrency,
      "sendAmount": this.sendAmount,
      "totalRecieveAmount": this.totalRecieveAmount,
      "promotionRate":this.promotionRate,
      "promotionCode":this.promotionCode

    };
  }
}
