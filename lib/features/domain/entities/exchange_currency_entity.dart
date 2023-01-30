import 'package:equatable/equatable.dart';

import '../../data/remote/models/currency_model.dart';

class ExchangeCurrencyEntity extends Equatable {
  final   String? name;
  final   double? val;


  ExchangeCurrencyEntity({
    this.name,this.val

  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,val
      ];
}
