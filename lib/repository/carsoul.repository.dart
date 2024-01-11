import 'dart:convert';

import 'package:daily_recipe2/models/ad.models.dart';
import 'package:flutter/services.dart';

class CarsoulRepository {

  Future <List<Ad>> getAds() async {
    var adsData = await rootBundle.loadString('assets/data/sample.json');
    var dataDecoded =
        List<Map<String, dynamic>>.from(jsonDecode(adsData)['ads']);
    //  print(dataDecoded);
  return   dataDecoded.map((e) => Ad.fromJson(e)).toList();
    // print(CarsoulState(adsLists:state.adsLists));
  }

  //   Future<List<Ad>> getAds() async {
//     var adsData = await rootBundle.loadString('assets/data/sample.json');
//     var dataDecoded =
//         List<Map<String, dynamic>>.from(jsonDecode(adsData)['ads']);
//     //  print(dataDecoded);
//   //  adsLists = dataDecoded.map((e) => Ad.fromJson(e)).toList();
//     carsoulRepository.getAds().then((adsLists){
//     emit(CarsoulLoading());
//      Future.delayed(Duration(seconds: 3), () {
//       this.adsLists = adsLists;
//       emit(CarsoulLoaded(adsLists));
//     });
//     });
// return adsLists;
//     // print(CarsoulState(adsLists:state.adsLists));
//   }

}