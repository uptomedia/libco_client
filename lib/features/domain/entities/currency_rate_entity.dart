import 'package:equatable/equatable.dart';

import '../../data/remote/models/currency_model.dart';

class CurrencyRateEntity extends Equatable {
  final   Data? data;


  CurrencyRateEntity({
    this.data,

  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        data,
      ];
}
