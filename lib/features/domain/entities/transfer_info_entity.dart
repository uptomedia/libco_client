import 'package:equatable/equatable.dart';

class TransferInfoEntity extends Equatable {
  final String? userName;
  final String? UId;
  final double? receiveAmount;
  final double? exchangeRate;
  final String? paymentCurrency;
  final String? recieveCurrency;
  final double? sendAmount;
  final double? totalRecieveAmount;
  final double? promotionRate;
  final String?  promotionCode;

  TransferInfoEntity({
    this.userName,
    this.UId,
    this.receiveAmount,
    this.exchangeRate,
    this.paymentCurrency,
    this.recieveCurrency,
    this.sendAmount,
    this.totalRecieveAmount,
    this.promotionCode,
    this.promotionRate
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
     userName,
    UId,
     receiveAmount,
     exchangeRate,
    paymentCurrency,
     recieveCurrency,
     sendAmount,
     totalRecieveAmount,
     promotionCode,
     promotionRate
      ];
}
