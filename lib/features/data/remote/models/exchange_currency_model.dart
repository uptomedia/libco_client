import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/exchange_currency_entity.dart';
import '../../../domain/entities/provider_entity.dart';
import '../../../domain/entities/user_entity.dart';
import 'countrys_rate_model.dart';

class ExchangeCurrencyModel extends ExchangeCurrencyEntity {
  ExchangeCurrencyModel({final String?name, final double? val}): super(
      name: name,
       val:val,
   );

  factory ExchangeCurrencyModel.fromSnapshot(DocumentSnapshot documentSnapshot) {


    return ExchangeCurrencyModel(
        name:(documentSnapshot.data() as Map)['name']??"no name",
        val: double.tryParse((
            documentSnapshot.data() as Map)['val'].toString())??1.0,



    );
  }

  Map<String, dynamic> toDocument() {
    return {"name": name, "val": val, };
  }
}
