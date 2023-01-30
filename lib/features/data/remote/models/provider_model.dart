import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/provider_entity.dart';
import '../../../domain/entities/user_entity.dart';
import 'countrys_rate_model.dart';

class ProviderModel extends ProviderEntity {
  ProviderModel({
    final String? name,
    final String? imagePath,
    final String? providerId,
    final   Stream<List<CountrysRatesModel>>? countryrate}) : super(
            name: name,
            imagePath:imagePath,
            providerId: providerId,
      countryrate:countryrate
  );


  factory ProviderModel.fromSnapshot(DocumentSnapshot documentSnapshot) {


    return ProviderModel(
      name:(documentSnapshot.data() as Map)['name']??"no name",
      imagePath: (documentSnapshot.data() as Map)['imagePath']??"no image",
      providerId: (documentSnapshot.data() as Map)['providerId']??"uid",
      countryrate:

    //     var collection = FirebaseFirestore.instance
    //     .collection('ingredients');
    //
    // collection.get().then((value) {
    //   value.docs.forEach((element) {
    //     setState(() {
    //       // add the object to the List
    //       ingredients.add(Ingredient(Ingredient.fromMap(element.data())));
    //     });
    //   });
    // });
      documentSnapshot
          .reference.

      collection("countryrate")!=null?
       documentSnapshot
          .reference.

      collection("countryrate").snapshots().map(
              (querySnap) {
            return querySnap.docs.map((docSnap) =>
                CountrysRatesModel.fromSnapshot(docSnap)).toList();
         }):Stream.empty()



     );
  }

  Map<String, dynamic> toDocument() {
    return {"name": name, "imagePath": imagePath, "providerId": providerId,"countryrate":countryrate};
  }
}
